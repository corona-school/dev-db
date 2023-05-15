/* WARN: This touches all dissolved matches! */

/* Preparation: The dissolvedAt column should not be filled yet */
SELECT COUNT(*) FROM "match" WHERE "dissolvedAt" IS NOT NULL;


/* Fill the dissolvedAt column from the transaction log */
UPDATE "match"
  SET "match"."dissolvedAt" = "match_with_log"."log_dissolvedAt"
  
FROM (
  SELECT "match"."id" AS "match_id", "match"."dissolved" AS "match_dissolved", "log"."createdAt" AS "log_dissolvedAt"  FROM "match" 
    INNER JOIN "log" ON "match"."id" = ("log"."data"::json->>'matchId')::int
) AS "match_with_log" 

WHERE 
    "match_with_log"."match_id" = "match"."id" AND 
    "match_with_log"."match_dissolved" = TRUE;




/* Verify that all matches were updated correctly */
SELECT COUNT(*) AS "dissolved_but_no_date" FROM "match" WHERE "dissolved" = TRUE AND "dissolvedAt" IS NULL;
SELECT COUNT(*) AS "not_dissolved_but_date" FROM "match" WHERE "dissolved" = FALSE AND "dissolvedAt" IS NOT NULL;
SELECT COUNT(*) AS "correctly_filled" FROM "match" WHERE "dissolved" = TRUE AND "dissolvedAt" IS NOT NULL;

