/* NOTE: This can be run against PROD without precaution */

SELECT COUNT(*) AS "matches ongoing" FROM "match" WHERE dissolved IS FALSE;
SELECT COUNT(*) AS "matches dissolved" FROM "match" WHERE dissolved IS TRUE;