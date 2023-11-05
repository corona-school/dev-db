/* Migrate Unsubscribes, Spam Accounts and Hard Bouncing E-Mails from Mailjet to Unsubscribes in our DB (which users can manage via the User-App),
    as we now also want to send Marketing Campaigns via the Notification System */

/* Create a Temporary Table holding all emails to unsubscribe */
CREATE TABLE "temp_unsubscribe_emails" ("email" VARCHAR NOT NULL);


INSERT INTO "temp_unsubscribe_emails" VALUES
('test+dev+p1@lern-fair.de');

/* Find out what to update */

SELECT COUNT(*) AS "unsubscribe_pupils_all" FROM "pupil" WHERE "email" IN(SELECT * FROM "temp_unsubscribe_emails");
SELECT COUNT(*) INTO "unsubscribe_pupils_active" FROM "pupil" WHERE "email" IN(SELECT * FROM "temp_unsubscribe_emails") AND "active" = TRUE;
SELECT COUNT(*) INTO "unsubscribe_pupils_has_newsletter" FROM "pupil" WHERE "email" IN(SELECT * FROM "temp_unsubscribe_emails") AND "active" = TRUE AND "newsletter" = TRUE;


SELECT COUNT(*) AS "unsubscribe_students_all" FROM "student" WHERE "email" IN(SELECT * FROM "temp_unsubscribe_emails");
SELECT COUNT(*) INTO "unsubscribe_students_active" FROM "student" WHERE "email" IN(SELECT * FROM "temp_unsubscribe_emails") AND "active" = TRUE;
SELECT COUNT(*) INTO "unsubscribe_students_has_newsletter" FROM "student" WHERE "email" IN(SELECT * FROM "temp_unsubscribe_emails") AND "active" = TRUE AND "newsletter" = TRUE;

SELECT
    "notificationPreferences" AS "old",
    "notificationPreferences"::jsonb || '{ "news": { "email": false }, "event": { "email": false }, "request": { "email": false }, "alternative": { "email": false } }'::jsonb AS "new"
  FROM "pupil"
  WHERE
    "email" IN(SELECT * FROM "temp_unsubscribe_emails") AND "active" = TRUE AND "newsletter" = TRUE;


SELECT
    "notificationPreferences" AS "old",
    "notificationPreferences"::jsonb || '{ "news": { "email": false }, "event": { "email": false }, "request": { "email": false }, "alternative": { "email": false } }'::jsonb AS "new"
  FROM "student"
  WHERE
    "email" IN(SELECT * FROM "temp_unsubscribe_emails") AND "active" = TRUE AND "newsletter" = TRUE;



/* The Actual Update */
/* UPDATE "pupil"
  SET
    "newsletter" = FALSE,
    "notificationPreferences" = "notificationPreferences"::jsonb || '{ "news": { "email": false }, "event": { "email": false }, "request": { "email": false }, "alternative": { "email": false } }'::jsonb
  WHERE
    "email" IN(SELECT * FROM "temp_unsubscribe_emails") AND "active" = TRUE AND "newsletter" = TRUE; */
  

/* UPDATE "student"
  SET
    "newsletter" = FALSE,
    "notificationPreferences" = "notificationPreferences"::jsonb || '{ "news": { "email": false }, "event": { "email": false }, "request": { "email": false }, "alternative": { "email": false } }'::jsonb
  WHERE
    "email" IN(SELECT * FROM "temp_unsubscribe_emails") AND "active" = TRUE AND "newsletter" = TRUE; */

/* Cleanup */
DROP TABLE "temp_unsubscribe_emails";