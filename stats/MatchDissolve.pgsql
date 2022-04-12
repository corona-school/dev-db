SELECT COUNT(*) AS "dissolved_total"
  FROM "match"
  WHERE "dissolved" IS TRUE;

SELECT COUNT(*) AS "dissolved_total"
  FROM "log"
  WHERE "log"."logtype" = 'matchDissolve';

SELECT COUNT(*) AS "log_entry_broken"
  FROM "log"
  WHERE "log"."logtype" = 'matchDissolve' AND 
  NOT EXISTS(SELECT * FROM "pupil" WHERE "pupil"."wix_id" = "log"."user") AND
  NOT EXISTS(SELECT * FROM "student" WHERE "student"."wix_id" = "log"."user");
  
SELECT 
  COUNT(*) AS "dissolved_by_pupil",
  "match"."dissolveReason"
FROM "log"
INNER JOIN "match" ON "match"."id" = ("data"::json->>'matchId')::int
WHERE 
  "log"."logtype" = 'matchDissolve' AND
  EXISTS(SELECT * FROM "pupil" WHERE "pupil"."wix_id" = "log"."user")
GROUP BY "match"."dissolveReason"
ORDER BY "match"."dissolveReason";

SELECT 
  COUNT(*) AS "dissolved_by_student",
  "match"."dissolveReason"
FROM "log"
INNER JOIN "match" ON "match"."id" = ("data"::json->>'matchId')::int
WHERE 
  "log"."logtype" = 'matchDissolve' AND
  EXISTS(SELECT * FROM "student" WHERE "student"."wix_id" = "log"."user")
GROUP BY "match"."dissolveReason"
ORDER BY "match"."dissolveReason";
