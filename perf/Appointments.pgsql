/* --------- ANALYSIS ----------- */

/* 
Before:
Aggregate  (cost=4014.94..4014.94 rows=1 width=8)
  ->  Limit  (cost=4014.54..4014.59 rows=100 width=12)
        ->  Sort  (cost=4014.54..4014.71 rows=332 width=12)
              Sort Key: lecture.start
              ->  Seq Scan on lecture  (cost=2002.58..4012.00 rows=332 width=12)
                    Filter: ((NOT "isCanceled") AND ("appointmentType" <> 'screening'::lecture_appointmenttype_enum) AND (NOT ("declinedBy" @> '{pupil/3988}'::text[])) AND (("subcourseId" IS NULL) OR (hashed SubPlan 1)) AND (("participantIds" @> '{pupil/3988}'::text[]) OR ("organizerIds" @> '{pupil/3988}'::text[])))
                    SubPlan 1
                      ->  Hash Join  (cost=45.34..1988.19 rows=28768 width=4)
                            Hash Cond: (t0."subcourseId" = j0.id)
                            ->  Seq Scan on lecture t0  (cost=0.00..1925.14 rows=33714 width=8)
                                  Filter: (id IS NOT NULL)
                            ->  Hash  (cost=38.69..38.69 rows=1902 width=4)
                                  ->  Seq Scan on subcourse j0  (cost=0.00..38.69 rows=1902 width=4)
                                 Filter: published

After:
Aggregate  (cost=2627.91..2627.91 rows=1 width=8)
  ->  Limit  (cost=2627.51..2627.56 rows=100 width=12)
        ->  Sort  (cost=2627.51..2627.67 rows=331 width=12)
              Sort Key: lecture.start
              ->  Bitmap Heap Scan on lecture  (cost=2018.98..2624.98 rows=331 width=12)
                    Recheck Cond: (("participantIds" @> '{pupil/3988}'::text[]) OR ("organizerIds" @> '{pupil/3988}'::text[]))
                    Filter: ((NOT "isCanceled") AND ("appointmentType" <> 'screening'::lecture_appointmenttype_enum) AND (NOT ("declinedBy" @> '{pupil/3988}'::text[])) AND (("subcourseId" IS NULL) OR (hashed SubPlan 1)))
                    ->  BitmapOr  (cost=16.90..16.90 rows=440 width=0)
                          ->  Bitmap Index Scan on lecture_participantids  (cost=0.00..8.65 rows=437 width=0)
                                Index Cond: ("participantIds" @> '{pupil/3988}'::text[])
                          ->  Bitmap Index Scan on lecture_organizerids  (cost=0.00..8.21 rows=3 width=0)
                                Index Cond: ("organizerIds" @> '{pupil/3988}'::text[])
                    SubPlan 1
                      ->  Hash Join  (cost=45.34..1987.75 rows=28661 width=4)
                            Hash Cond: (t0."subcourseId" = j0.id)
                            ->  Seq Scan on lecture t0  (cost=0.00..1924.76 rows=33588 width=8)
                                  Filter: (id IS NOT NULL)
                            ->  Hash  (cost=38.69..38.69 rows=1902 width=4)
                                  ->  Seq Scan on subcourse j0  (cost=0.00..38.69 rows=1902 width=4)
                                        Filter: published
*/

EXPLAIN SELECT
    COUNT(*)
FROM
    (
        SELECT
            "public"."lecture"."id"
        FROM
            "public"."lecture"
        WHERE
            (
                "public"."lecture"."isCanceled" = false
                AND "public"."lecture"."appointmentType" <> 'screening'
                AND (NOT "public"."lecture"."declinedBy" @> '{pupil/3988}')
                AND (
                    "public"."lecture"."subcourseId" IS NULL
                    OR ("public"."lecture"."id") IN (
                        SELECT
                            "t0"."id"
                        FROM
                            "public"."lecture" AS "t0"
                            INNER JOIN "public"."subcourse" AS "j0" ON ("j0"."id") = ("t0"."subcourseId")
                        WHERE
                            (
                                "j0"."published" = true
                                AND "t0"."id" IS NOT NULL
                            )
                    )
                )
                AND (
                    "public"."lecture"."participantIds" @> '{pupil/3988}'
                    OR "public"."lecture"."organizerIds" @> '{pupil/3988}'
                )
            )
        ORDER BY
            "public"."lecture"."start" ASC
        LIMIT
            100
        OFFSET
            0
    ) AS "sub";

/* Indexes Before:
   CREATE INDEX lecture_subcourseid ON public.lecture USING hash ("subcourseId") WHERE ("subcourseId" IS NOT NULL)
   CREATE INDEX lecture_matchid ON public.lecture USING hash ("matchId") WHERE ("matchId" IS NOT NULL)
*/
SELECT
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    schemaname = 'public' AND tablename = 'lecture';

/* Index Usage + Cost 

Before:
schemaname,tablename,num_rows,table_size,index_name,index_size,unique,number_of_scans,tuples_read,tuples_fetched
public,lecture,33326,14 MB,PK_2abef7c1e52b7b58a9f905c9643,776 kB,Y,3776799,4107239,3829924
public,lecture,33326,14 MB,lecture_matchid,1232 kB,N,374362,7332887,54752
public,lecture,33326,14 MB,lecture_subcourseid,288 kB,N,71121879,504828197,157727641

public,lecture,33588,14 MB,lecture_participantids,1192 kB,N,14,1197,0
public,lecture,33588,14 MB,lecture_organizerids,296 kB,N,14,70,0
*/
SELECT
    t.schemaname,
    t.tablename,
    c.reltuples::bigint                            AS num_rows,
    pg_size_pretty(pg_relation_size(c.oid))        AS table_size,
    psai.indexrelname                              AS index_name,
    pg_size_pretty(pg_relation_size(i.indexrelid)) AS index_size,
    CASE WHEN i.indisunique THEN 'Y' ELSE 'N' END  AS "unique",
    psai.idx_scan                                  AS number_of_scans,
    psai.idx_tup_read                              AS tuples_read,
    psai.idx_tup_fetch                             AS tuples_fetched
FROM
    pg_tables t
    LEFT JOIN pg_class c ON t.tablename = c.relname
    LEFT JOIN pg_index i ON c.oid = i.indrelid
    LEFT JOIN pg_stat_all_indexes psai ON i.indexrelid = psai.indexrelid
WHERE
    t.tablename = 'lecture'
ORDER BY 1, 2;

/* -------- INDEX CREATION -------- */
CREATE INDEX lecture_participantids ON lecture USING GIN ("participantIds");
CREATE INDEX lecture_organizerids ON lecture USING GIN ("organizerIds");
VACUUM ANALYZE lecture;
