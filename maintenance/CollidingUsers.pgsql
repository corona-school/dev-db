SELECT COUNT(DISTINCT "user_id") AS "user_ids", COUNT(*) AS "users" FROM (
  SELECT "wix_id" AS "user_id" FROM "student"
    UNION
  SELECT "wix_id" AS "user_id" FROM "pupil"
    UNION
  SELECT "wix_id" AS "user_id" FROM "mentor"
) AS "users";