SELECT COUNT(*) AS "students total" FROM "student";
SELECT COUNT(*) AS "pupils total" FROM "pupil";

SELECT COUNT(*) AS "students unverified" FROM "student" WHERE "verifiedAt" IS NULL;
SELECT COUNT(*) AS "students unverified but authenticated?" FROM "student" WHERE "verifiedAt" IS NULL AND "authToken" IS NULL;

SELECT COUNT(*) AS "pupils unverified" FROM "pupil" WHERE "verifiedAt" IS NULL;
SELECT COUNT(*) AS "pupils unverified but authenticated?" FROM "pupil" WHERE "verifiedAt" IS NULL AND "authToken" IS NULL;