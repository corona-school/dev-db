SELECT 
  COUNT(*) AS "student_mails",
  date_part('day', "sentAt"::date) AS "day",
  date_part('month', "sentAt"::date) AS "month",
  date_part('year', "sentAt"::date) AS "year"
FROM "concrete_notification"
WHERE "notificationID" IN (12, 13, 14) AND "state" = 2
GROUP BY "day", "month", "year"
ORDER BY "year", "month", "day";

SELECT 
  COUNT(*) AS "pupil_mails",
  date_part('day', "sentAt"::date) AS "day",
  date_part('month', "sentAt"::date) AS "month",
  date_part('year', "sentAt"::date) AS "year"
FROM "concrete_notification"
WHERE "notificationID" IN (9, 10, 11) AND "state" = 2
GROUP BY "day", "month", "year"
ORDER BY "year", "month", "day";