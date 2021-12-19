SELECT COUNT(*) AS "verified pupils"
  FROM "pupil"
  WHERE "verifiedAt" IS NOT NULL AND "verification" IS NULL;

SELECT COUNT(*) AS "pupils with pending verification"
  FROM "pupil"
  WHERE "verifiedAt" IS NULL AND "verification" IS NOT NULL;


SELECT COUNT(*) AS "pupils with no verifiedAt and no verification token (HOW?)"
  FROM "pupil"
  WHERE "verifiedAt" IS NULL AND "verification" IS NULL;



SELECT COUNT(*) AS "verified students"
  FROM "student"
  WHERE "verifiedAt" IS NOT NULL AND "verification" IS NULL;

SELECT COUNT(*) AS "students with pending verification"
  FROM "student"
  WHERE "verifiedAt" IS NULL AND "verification" IS NOT NULL;

SELECT COUNT(*) AS "students with no verifiedAt and no verification token (HOW?)"
  FROM "student"
  WHERE "verifiedAt" IS NULL AND "verification" IS NULL;