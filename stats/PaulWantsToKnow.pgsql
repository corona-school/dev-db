SELECT COUNT(*) AS "pupils", "state" FROM "pupil"
 WHERE "isPupil" IS TRUE AND active IS TRUE
 GROUP BY "state";

SELECT COUNT(*) AS "students", "state" FROM "student"
  WHERE "isStudent" IS TRUE AND active IS TRUE
 GROUP BY "state";

SELECT COUNT(*) AS "pupils", "schooltype" FROM "pupil" 
  WHERE "isPupil" IS TRUE AND active IS TRUE
  GROUP BY "schooltype";

SELECT COUNT(*) AS "pupils", "grade" FROM "pupil" 
  WHERE "isPupil" IS TRUE AND active IS TRUE
  GROUP BY "grade";

SELECT json_array_elements("subjects"::json) ->> 'name' AS "subject", COUNT(*) AS "pupils" FROM "pupil" 
  WHERE "isPupil" IS TRUE AND active IS TRUE
  GROUP BY "subject";


SELECT json_array_elements("subjects"::json) ->> 'name' AS "subject", COUNT(*) AS "students" FROM "student"
  WHERE "isStudent" IS TRUE AND active IS TRUE
  GROUP BY "subject";

SELECT AVG(json_array_length("subjects"::json)) AS "average_subjects_pupils" FROM "pupil" 
  WHERE "isPupil" IS TRUE AND active IS TRUE;


SELECT AVG(json_array_length("subjects"::json)) AS "average_subjects_students" FROM "student"
  WHERE "isStudent" IS TRUE AND active IS TRUE;

/* number of subjects that matched */
WITH match_student_subjects AS (
    SELECT
      json_array_elements("student"."subjects"::json) ->> 'name' AS "student_subject", 
      "match"."id" AS "student_match"
    FROM "match"
    INNER JOIN "student" ON "match"."studentId" = "student"."id"
    ), match_pupil_subjects AS (
    SELECT
      json_array_elements("pupil"."subjects"::json) ->> 'name' AS "pupil_subject", 
      "match"."id" AS "pupil_match"
    FROM "match"
    INNER JOIN "pupil" ON "match"."pupilId" = "pupil"."id"
    
)
SELECT COUNT(*), "student_subject" FROM "match_student_subjects"
  INNER JOIN "match_pupil_subjects" ON "student_match" = "pupil_match" AND "student_subject" = "pupil_subject"
  GROUP BY "student_subject";

/* number of matching subjects */
WITH match_student_subjects AS (
    SELECT
      json_array_elements("student"."subjects"::json) ->> 'name' AS "student_subject", 
      "match"."id" AS "student_match"
    FROM "match"
    INNER JOIN "student" ON "match"."studentId" = "student"."id"
    ), match_pupil_subjects AS (
    SELECT
      json_array_elements("pupil"."subjects"::json) ->> 'name' AS "pupil_subject", 
      "match"."id" AS "pupil_match"
    FROM "match"
    INNER JOIN "pupil" ON "match"."pupilId" = "pupil"."id"
    
), counts AS (
    SELECT COUNT(*) AS "matching_subjects" FROM "match_student_subjects"
  INNER JOIN "match_pupil_subjects" ON "student_match" = "pupil_match" AND "student_subject" = "pupil_subject"
  GROUP BY "student_match"
) SELECT "matching_subjects", COUNT(*) AS "matches" FROM counts GROUP BY "matching_subjects";