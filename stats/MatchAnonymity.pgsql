SELECT COUNT(*) AS "same_date"
 FROM "match"
 GROUP BY "createdAt"
 ORDER BY "same_date" ASC
 LIMIT 10000
 ;