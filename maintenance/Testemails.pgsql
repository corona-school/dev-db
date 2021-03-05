/* WARN: This modifies the testuser!  */

BEGIN TRANSACTION;

SELECT * FROM student WHERE "id" = 3627;
SELECT * FROM pupil   WHERE "id" = 3988;

UPDATE student
  SET "email" = 'invalid3@example.org' 
  WHERE "id" = 3627;

UPDATE pupil
  SET "email" = 'invalid1@example.org'
  WHERE "id" = 3988;

SELECT * FROM student WHERE "id" = 3627;
SELECT * FROM pupil   WHERE "id" = 3988;

/* toggle to update */
ROLLBACK TRANSACTION;
/* COMMIT TRANSACTION; */