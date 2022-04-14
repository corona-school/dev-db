/* Number of active tutees, tutors and matches */
SELECT COUNT(*) FROM "pupil" WHERE "isPupil" IS TRUE AND active IS TRUE;
SELECT COUNT(*) FROM "student" WHERE "isStudent" IS TRUE AND active IS TRUE;
SELECT COUNT(*) FROM "match";

/* number of tutees/tutors without subjects - not viable for matching */
SELECT COUNT(*) FROM "student"
  WHERE "isStudent" IS TRUE AND "student"."subjects" = '[]';

SELECT COUNT(*) FROM "pupil"
  WHERE "isPupil" IS TRUE AND "pupil"."subjects" = '[]';

/* ----------------- Tutee stats ----------------------------- */
SELECT COUNT(*) AS "pupils", "state" FROM "pupil"
 WHERE "isPupil" IS TRUE AND active IS TRUE
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

SELECT AVG(json_array_length("subjects"::json)) AS "average_subjects_pupils" FROM "pupil" 
  WHERE "isPupil" IS TRUE AND active IS TRUE;

/* ---------------- Tutor stats ------------------------------ */
SELECT COUNT(*) AS "students", "state" FROM "student"
  WHERE "isStudent" IS TRUE AND active IS TRUE
 GROUP BY "state";

SELECT json_array_elements("subjects"::json) ->> 'name' AS "subject", COUNT(*) AS "students" FROM "student"
  WHERE "isStudent" IS TRUE AND active IS TRUE
  GROUP BY "subject";

SELECT AVG(json_array_length("subjects"::json)) AS "average_subjects_students" FROM "student"
  WHERE "isStudent" IS TRUE AND active IS TRUE;

/* --------------- Match Stats (including dissolved) ------------------------------*/

/* matches per subject */
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
) SELECT COUNT(*), "matching_subjects" FROM counts GROUP BY "matching_subjects";

/* number of matches per tutor */
WITH matches_per_tutor AS (
  SELECT COUNT(*) AS "per_tutor_count" FROM "match"
    GROUP BY "studentId"
) SELECT COUNT(*), "per_tutor_count" FROM "matches_per_tutor" GROUP BY "per_tutor_count" ORDER BY "per_tutor_count" ASC;


/* number of matches per tutee */
WITH matches_per_tutee AS (
  SELECT COUNT(*) AS "per_tutee_count" FROM "match"
    GROUP BY "pupilId"
) SELECT COUNT(*), "per_tutee_count" FROM "matches_per_tutee" GROUP BY "per_tutee_count" ORDER BY "per_tutee_count" ASC;

/* Find extraordinary students */
WITH matches_per_tutor AS (
  SELECT COUNT(*) AS "per_tutor_count", "studentId" FROM "match"
    GROUP BY "studentId"
) SELECT * FROM "matches_per_tutor" INNER JOIN "student" ON "studentId" = "student"."id" WHERE "per_tutor_count" = 37 ;
