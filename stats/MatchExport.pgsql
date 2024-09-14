SELECT "student"."subjects", "student"."state", "match"."studentFirstMatchRequest" FROM "student"
  INNER JOIN "match" ON "match"."studentId" = "student"."id"
  WHERE "match"."studentFirstMatchRequest" IS NOT NULL
  ORDER BY "match"."studentFirstMatchRequest" ASC;

SELECT "pupil"."subjects", "pupil"."state", "match"."pupilFirstMatchRequest" FROM "pupil"
  INNER JOIN "match" ON "match"."pupilId" = "pupil"."id"
  WHERE "match"."pupilFirstMatchRequest" IS NOT NULL
  ORDER BY "match"."pupilFirstMatchRequest" ASC;

