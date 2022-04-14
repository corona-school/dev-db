BEGIN TRANSACTION;

/* - BEFORE: Number of pupils with inconsistent subjects -> 9486 */
WITH pupil_subjects AS (
    SELECT
      json_array_elements("pupil"."subjects"::json) ->> 'name' AS "subject", 
      "pupil"."id"
      FROM "pupil"
    )
SELECT COUNT(DISTINCT "id") AS "pupil_inconsistent_before" FROM "pupil_subjects" WHERE "subject" IS NULL;

/* - MIGRATION: Convert 'string' and 'Matlab format' to 'JSON format' */
WITH reformatting AS (
  SELECT 
      regexp_replace(
        "subjects",
        '(?<!\{.*)"([A-Za-zäöüßÄÖÜ]+)( )*"',
        '{ "name": "\1" }',
        'g'
      ) AS "new_subjects",
  "subjects",
  "id"
FROM "pupil"
)
/* UPDATE "pupil"
  SET "subjects" = "reformatting"."new_subjects"
FROM "reformatting"
WHERE "pupil"."id" = "reformatting"."id" AND "pupil"."subjects" = "reformatting"."subjects" AND "pupil"."subjects" <> "reformatting"."new_subjects"; */


SELECT * FROM "reformatting" WHERE "subjects" <> "new_subjects"; /* -> pupil_formatting_full.json */
/* SELECT COUNT(*) FROM "reformatting" WHERE "subjects" <> "new_subjects"; -> 9486 */

/* - AFTER: Number of pupils with inconsistent subjects -> 0? */
WITH pupil_subjects AS (
    SELECT
      json_array_elements("pupil"."subjects"::json) ->> 'name' AS "subject", 
      "pupil"."id"
      FROM "pupil"
    )
SELECT COUNT(DISTINCT "id") AS "pupil_inconsistent_after" FROM "pupil_subjects" WHERE "subject" IS NULL;


ROLLBACK TRANSACTION;