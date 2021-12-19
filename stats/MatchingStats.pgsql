/* ----------------- PUPIL MATCHING STATS ------------------- */
/* NOTE: E-Mail blacklisting is not taken into account, real matching numbers may be lower */

SELECT COUNT(*) AS "unmatched non-cooperation pupils" 
  FROM "pupil"
  LEFT JOIN "pupil_tutoring_interest_confirmation_request" AS "cr" ON "cr"."pupilId" = "pupil"."id"
  WHERE 
    "active" IS TRUE AND
    "openMatchRequestCount" > 0 AND
    "isPupil" IS TRUE AND 
    "verification" IS NULL AND /* Why ? */
    "subjects" <> '[]' AND 
    "cr"."status" = 'confirmed';

SELECT COUNT(*) AS "unmatched cooperation pupils" 
  FROM "pupil"
  LEFT JOIN "pupil_tutoring_interest_confirmation_request" AS "cr" ON "cr"."pupilId" = "pupil"."id"
  WHERE 
    "active" IS TRUE AND
    "openMatchRequestCount" > 0 AND
    "isPupil" IS TRUE AND 
    "verification" IS NULL AND /* Why ? */
    "subjects" <> '[]' AND 
    "registrationSource" = '1' /* Cooperation */;

/* ------------- STUDENT MATCHING STATS --------------- */

SELECT COUNT(*) AS "unmatched students" FROM "student"
  INNER JOIN "screening" ON "screening"."studentId" = "student"."id"
  WHERE 
    "active" IS TRUE AND
    "verification" IS NULL AND
    "isStudent" IS TRUE AND 
    "openMatchRequestCount" > 0 AND
    "subjects" <> '[]' AND
    "screening"."success" IS TRUE; 


/* ----------- MATCH STATS -------------------------- */

SELECT 
  COUNT(*) AS "matches created",
  "createdAt"::DATE as "on" 
  FROM "match"
  WHERE
    "dissolved" IS FALSE AND 
    "createdAt" > NOW()::DATE - 7
  GROUP BY "createdAt"::DATE;