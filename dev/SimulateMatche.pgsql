/* ATTENTION: DEV ONLY! */

ALTER TABLE "match" DROP CONSTRAINT "UQ_MATCH";
  
INSERT INTO "match" ("studentId", "pupilId", "uuid", "createdAt")
  SELECT 
    1 AS "studentId",
    1 AS "pupilId",
    gen_random_uuid () AS "uuid",
    generate_series(
        date '2021-09-01',
        date '2022-01-31',
        '1 day'
    ) AS "createdAt";
