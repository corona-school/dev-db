BEGIN TRANSACTION;

/* - BEFORE: Number of students with inconsistent subjects -> 8076 */
WITH student_subjects AS (
    SELECT
      json_array_elements("student"."subjects"::json) ->> 'name' AS "subject", 
      "student"."id"
      FROM "student"
    )
SELECT COUNT(DISTINCT "id") AS "students_inconsistent_before" FROM "student_subjects" WHERE "subject" IS NULL;

/* - MIGRATION: Convert 'string' and 'Matlab format' to 'JSON format' */
WITH reformatting AS (
  SELECT regexp_replace(
      regexp_replace(
        "subjects",
        '(?<!\{.*)"([A-Za-zäöüßÄÖÜ]+)( )*"',
        '{ "name": "\1" }',
        'g'
      ),
      '"([A-Za-zäöüßÄÖÜ]+)([0-9]+):([0-9]+)( )*"',
      '{ "name": "\1", "minGrade": \2, "maxGrade": \3 }',
      'g'
  ) AS "new_subjects",
  "subjects",
  "id"
FROM "student"
)
UPDATE "student"
  SET "subjects" = "reformatting"."new_subjects"
FROM "reformatting"
WHERE "student"."id" = "reformatting"."id" AND "student"."subjects" = "reformatting"."subjects" AND "student"."subjects" <> "reformatting"."new_subjects";


/* SELECT * FROM "reformatting" WHERE "subjects" <> "new_subjects"; -> student_formatting_full.json */
/* SELECT COUNT(*) FROM "reformatting" WHERE "subjects" <> "new_subjects"; -> 8076 */

/* - AFTER: Number of students with inconsistent subjects -> 0? */
WITH student_subjects AS (
    SELECT
      json_array_elements("student"."subjects"::json) ->> 'name' AS "subject", 
      "student"."id"
      FROM "student"
    )
SELECT COUNT(DISTINCT "id") AS "students_inconsistent_after" FROM "student_subjects" WHERE "subject" IS NULL;


ROLLBACK TRANSACTION;