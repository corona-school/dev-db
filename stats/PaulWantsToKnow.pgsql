SELECT COUNT(*) AS "pupils", "state" FROM "pupil"
 GROUP BY "state";

SELECT COUNT(*) AS "students", "state" FROM "student"
 GROUP BY "state";

SELECT COUNT(*) AS "pupils", "schooltype" FROM "pupil" GROUP BY "schooltype";

SELECT COUNT(*) AS "pupils", "grade" FROM "pupil" GROUP BY "grade";

SELECT json_array_elements("subjects"::json) ->> 'name' AS "subject", COUNT(*) AS "pupils" FROM "pupil" GROUP BY "subject";


SELECT json_array_elements("subjects"::json) ->> 'name' AS "subject", COUNT(*) AS "students" FROM "student" GROUP BY "subject";