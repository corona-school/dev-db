/* WARN: This touches user accounts! */

/* We have three users with an invalid email (not correctly lowercased) */
SELECT "email" FROM "student" WHERE "email" != lower("email");

SELECT "email" FROM "pupil" WHERE "email" != lower("email");

/* Fix users */
BEGIN TRANSACTION;

UPDATE "student" 
  SET "email" = lower("email")
  WHERE "email" != lower("email");

ROLLBACK TRANSACTION;


BEGIN TRANSACTION;

UPDATE "pupil"
  SET "email" = lower("email")
  WHERE "email" != lower("email");

ROLLBACK TRANSACTION;