/* Pupils */
WITH "pupilsIds" AS (
    SELECT "pupil"."wix_id" AS "wix_id", 'pupil/' || "pupil"."id" AS "userID" 
    FROM "log" 
    INNER JOIN "pupil" ON "log"."user" = "pupil"."wix_id"
) 
UPDATE "log" 
SET "userID" = "pupilsIds"."userID" 
FROM "pupilsIds"
WHERE "log"."user" = "pupilsIds"."wix_id";

/* Students */
WITH "studentsIds" AS (
    SELECT "student"."wix_id" AS "wix_id", 'student/' || "student"."id" AS "userID" 
    FROM "log" 
    INNER JOIN "student" ON "log"."user" = "student"."wix_id"
) 
UPDATE "log" 
SET "userID" = "studentsIds"."userID" 
FROM "studentsIds"
WHERE "log"."user" = "studentsIds"."wix_id";


/* Mentors */
WITH "mentorsIds" AS (
    SELECT "mentor"."wix_id" AS "wix_id", 'mentor/' || "mentor"."id" AS "userID" 
    FROM "log" 
    INNER JOIN "mentor" ON "log"."user" = "mentor"."wix_id"
) 
UPDATE "log" 
SET "userID" = "mentorsIds"."userID" 
FROM "mentorsIds"
WHERE "log"."user" = "mentorsIds"."wix_id";
