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

SELECT "subjects" FROM "student" LIMIT 10;