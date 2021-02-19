/* This is more or less what /api/screening/courses does right now: */

EXPLAIN ANALYZE
  SELECT 
    "public"."course"."id", 
    "public"."course"."createdAt", 
    "public"."course"."updatedAt", 
    "public"."course"."name",
    "public"."course"."outline",
    "public"."course"."description",
    "public"."course"."imageKey",
    "public"."course"."courseState",
    "public"."course"."category",
    "public"."course"."screeningComment",
    "public"."course"."publicRanking",
    "public"."course"."allowContact",
    "public"."course"."correspondentId"
   FROM "public"."course" 
   WHERE (("public"."course"."courseState" = 'allowed' AND LOWER("public"."course"."name") ILIKE '%a%') OR ("public"."course"."courseState" = 'allowed' AND LOWER("public"."course"."description") ILIKE '%a%'))
   /* WHERE ("public"."course"."courseState" = 'allowed' OR "public"."course"."courseState" = 'allowed') */
   ORDER BY "public"."course"."updatedAt" 
   DESC LIMIT 20 OFFSET 20

/* 
Run against PROD on 2021/02/19

Without text search: 

Limit  (cost=60.32..60.33 rows=20 width=1106) (actual time=0.461..0.464 rows=20 loops=1)
  ->  Sort  (cost=60.31..60.44 rows=262 width=1106) (actual time=0.457..0.460 rows=40 loops=1)
        Sort Key: "updatedAt" DESC
        Sort Method: top-N heapsort  Memory: 131kB
        ->  Seq Scan on course  (cost=0.00..58.66 rows=262 width=1106) (actual time=0.011..0.281 rows=261 loops=1)
              Filter: ("courseState" = 'allowed'::course_coursestate_enum)
              Rows Removed by Filter: 207
Planning Time: 0.570 ms
Execution Time: 0.500 ms

With text search:

Limit  (cost=61.27..61.28 rows=20 width=1106) (actual time=2.098..2.102 rows=20 loops=1)
  ->  Sort  (cost=61.26..61.39 rows=262 width=1106) (actual time=2.095..2.098 rows=40 loops=1)
        Sort Key: "updatedAt" DESC
        Sort Method: top-N heapsort  Memory: 131kB
        ->  Seq Scan on course  (cost=0.00..59.60 rows=262 width=1106) (actual time=0.062..1.960 rows=261 loops=1)
              Filter: (("courseState" = 'allowed'::course_coursestate_enum) AND ((lower((name)::text) ~~* '%a%'::text) OR (lower((description)::text) ~~* '%a%'::text)))
              Rows Removed by Filter: 207
Planning Time: 0.580 ms
Execution Time: 2.125 ms

*/