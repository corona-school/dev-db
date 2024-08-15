-- For historical reasons, there are two ways to verify a user:
-- verifiedAt IS NOT NULL (current timestamp is set when email is verified)
-- verification IS NULL (random token is removed when email is verified)

-- This migration populates the `verifiedAt` field for those 
-- users that are only verified via verification column.


-- MIGRATE PUPILS  --
UPDATE pupil SET "verifiedAt" = "createdAt"
WHERE verification IS NULL
AND "verifiedAt" IS NULL

SELECT COUNT(*) FROM pupil WHERE "verifiedAt" IS NULL AND verification IS NULL

-- MIGRATE STUDENTS  --
UPDATE student SET "verifiedAt" = "createdAt"
WHERE verification IS NULL
AND "verifiedAt" IS NULL

SELECT COUNT(*) FROM student WHERE "verifiedAt" IS NULL AND verification IS NULL

-- MIGRATE SCREENERS  --
UPDATE screener SET "verifiedAt" = "createdAt"
WHERE verification IS NULL
AND "verifiedAt" IS NULL

SELECT COUNT(*) FROM screener WHERE "verifiedAt" IS NULL AND verification IS NULL