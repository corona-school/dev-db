/* Migrate pupils */
BEGIN TRANSACTION;

SELECT "id", "registrationSource" FROM "pupil" WHERE "registrationSource" = '5';

UPDATE "pupil" SET 
    "registrationSource" = '0' 
    WHERE "registrationSource" = '5';

SELECT "id", "registrationSource" FROM "pupil" WHERE "registrationSource" = '5';

ROLLBACK TRANSACTION;

SELECT "id", "registrationSource" FROM "pupil" WHERE "registrationSource" = '5';

/* Migrate students */

BEGIN TRANSACTION;

SELECT "id", "registrationSource" FROM "student" WHERE "registrationSource" = '5';

UPDATE "student" SET 
    "registrationSource" = '0' 
    WHERE "registrationSource" = '5';

SELECT "id", "registrationSource" FROM "student" WHERE "registrationSource" = '5';

ROLLBACK TRANSACTION;

SELECT "id", "registrationSource" FROM "student" WHERE "registrationSource" = '5';