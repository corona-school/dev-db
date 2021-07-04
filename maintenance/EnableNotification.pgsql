/* ATTENTION: By enabling a notification, hundreds of users might get emails, depending on the onActions! */

BEGIN TRANSACTION;

UPDATE 
  SET enabled = TRUE 
  WHERE id = -1 /* insert id here */
  FROM "notification";

ROLLBACK TRANSACTION;
/* COMMIT TRANSACTION; */