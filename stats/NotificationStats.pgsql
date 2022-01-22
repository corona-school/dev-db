/* NOTE: This can be run against PROD without precaution */

SELECT "notificationID", COUNT(*) AS "notifications_sent" 
  FROM "concrete_notification"
  WHERE "state" = 2
  GROUP BY "notificationID";

SELECT "notificationID", COUNT(*) AS "notifications_scheduled" 
  FROM "concrete_notification"
  WHERE "state" = 0
  GROUP BY "notificationID";

SELECT "notificationID", COUNT(*) AS "notifications_errored" 
  FROM "concrete_notification"
  WHERE "state" = 3
  GROUP BY "notificationID";

SELECT "notificationID", COUNT(*) AS "notifications_action_taken" 
  FROM "concrete_notification"
  WHERE "state" = 4
  GROUP BY "notificationID";

SELECT 
    COUNT(*) AS "notifications_scheduled",
    date_part('week', "sentAt"::date) AS "week",
    date_part('year', "sentAt"::date) AS "year"
  FROM "concrete_notification"
  WHERE "state" = 0
  GROUP BY "week", "year"
  ORDER BY "year", "week";