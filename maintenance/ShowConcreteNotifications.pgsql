SELECT * FROM "concrete_notification"
  LEFT JOIN "notification" ON "notification"."id" = "concrete_notification"."notificationID"
  LIMIT 100;