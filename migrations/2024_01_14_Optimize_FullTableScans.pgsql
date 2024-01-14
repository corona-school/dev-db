
/* Scenario 1: Select from concrete notifications by userId (we always do this)

Before:
Seq Scan on concrete_notification  (cost=0.00..27843.85 rows=18 width=362) (actual time=136.785..136.785 rows=0 loops=1)
  Filter: (("userId")::text = 'pupil/1000'::text)
  Rows Removed by Filter: 422271
Planning Time: 0.444 ms
Execution Time: 136.805 ms

After:
Bitmap Heap Scan on concrete_notification  (cost=2.03..37.62 rows=18 width=362) (actual time=0.054..0.055 rows=0 loops=1)
  Recheck Cond: (("userId")::text = 'pupil/1000'::text)
  ->  Bitmap Index Scan on concrete_notification_userid  (cost=0.00..2.03 rows=18 width=0) (actual time=0.053..0.053 rows=0 loops=1)
        Index Cond: (("userId")::text = 'pupil/1000'::text)
Planning Time: 0.598 ms
Execution Time: 0.079 ms

*/
EXPLAIN ANALYZE SELECT * FROM "concrete_notification" WHERE "userId" = 'pupil/1000';

/* Hash index as we always do equality predicates */
CREATE INDEX CONCURRENTLY concrete_notification_userId  ON "concrete_notification" USING hash("userId");


/* Scenario 2: Select Appointments by Match or Subcourse 

Before:
Seq Scan on lecture  (cost=0.00..414.44 rows=2 width=497) (actual time=0.480..1.805 rows=1 loops=1)
  Filter: ("subcourseId" = 1000)
  Rows Removed by Filter: 5560
Planning Time: 0.482 ms
Execution Time: 1.832 ms

Seq Scan on lecture  (cost=0.00..414.44 rows=4 width=497) (actual time=2.901..2.902 rows=0 loops=1)
  Filter: ("matchId" = 1000)
  Rows Removed by Filter: 5561
Planning Time: 1.393 ms
Execution Time: 2.931 ms

After:
Bitmap Heap Scan on lecture  (cost=2.00..5.87 rows=2 width=497) (actual time=0.035..0.036 rows=1 loops=1)
  Recheck Cond: ("subcourseId" = 1000)
  Heap Blocks: exact=1
  ->  Bitmap Index Scan on lecture_subcourseid  (cost=0.00..2.00 rows=2 width=0) (actual time=0.024..0.024 rows=1 loops=1)
        Index Cond: ("subcourseId" = 1000)
Planning Time: 0.768 ms
Execution Time: 0.069 ms

Bitmap Heap Scan on lecture  (cost=2.01..9.62 rows=4 width=497) (actual time=0.024..0.024 rows=0 loops=1)
  Recheck Cond: ("matchId" = 1000)
  ->  Bitmap Index Scan on lecture_matchid  (cost=0.00..2.01 rows=4 width=0) (actual time=0.022..0.022 rows=0 loops=1)
        Index Cond: ("matchId" = 1000)
Planning Time: 0.723 ms
Execution Time: 0.060 ms

*/
EXPLAIN ANALYZE SELECT * FROM "lecture" WHERE "subcourseId" = 1000;
EXPLAIN ANALYZE SELECT * FROM "lecture" WHERE "matchId" = 1000;

CREATE INDEX CONCURRENTLY lecture_matchId  ON "lecture" USING hash("matchId") WHERE "matchId" IS NOT NULL;
CREATE INDEX CONCURRENTLY lecture_subcourseId  ON "lecture" USING hash("subcourseId") WHERE "subcourseId" IS NOT NULL;


/* Scenario 3: Find Secrets
Before:
Seq Scan on secret  (cost=0.00..1222.40 rows=1 width=198) (actual time=6.614..6.615 rows=0 loops=1)
  Filter: (("userId")::text = 'pupil/1000'::text)
  Rows Removed by Filter: 21336
Planning Time: 0.426 ms
Execution Time: 6.635 ms

After:
Index Scan using secret_userid on secret  (cost=0.00..4.00 rows=1 width=198) (actual time=0.024..0.024 rows=0 loops=1)
  Index Cond: (("userId")::text = 'pupil/1000'::text)
Planning Time: 0.463 ms
Execution Time: 0.046 ms

*/
EXPLAIN ANALYZE SELECT * FROM "secret" WHERE "userId" = 'pupil/1000';

CREATE INDEX CONCURRENTLY secret_userId  ON "secret" USING hash("userId");



/* Scenario 4: Find Lectures of User

Before:
Seq Scan on lecture  (cost=0.00..425.59 rows=4 width=497) (actual time=3.105..3.106 rows=0 loops=1)
  Filter: ('pupil/1000'::text = ANY ("participantIds"))
  Rows Removed by Filter: 5561
Planning Time: 0.756 ms
Execution Time: 3.221 ms

Seq Scan on lecture  (cost=0.00..425.59 rows=1 width=497) (actual time=2.912..2.912 rows=0 loops=1)
  Filter: ('pupil/1000'::text = ANY ("organizerIds"))
  Rows Removed by Filter: 5561
Planning Time: 0.801 ms
Execution Time: 2.935 ms


*/
EXPLAIN ANALYZE SELECT * FROM "lecture" WHERE 'pupil/1000' = ANY("participantIds");
EXPLAIN ANALYZE SELECT * FROM "lecture" WHERE 'pupil/1000' = ANY("organizerIds");

/* -> Unfortunately Postgres does not support Hash Indices on Arrays :/ */