/* NOTE: This can be run against PROD without precaution */

EXPLAIN ANALYZE
 SELECT * FROM course
  /* join instructors */
  LEFT JOIN course_instructors_student ON "course_instructors_student"."courseId" = "course"."id"
  INNER JOIN student ON "course_instructors_student"."studentId" = "student"."id"
  /* join tags */
  LEFT JOIN course_tags_course_tag ON "course_tags_course_tag"."courseId" = "course"."id"
  INNER JOIN course_tag ON "course_tags_course_tag"."courseTagId" = "course_tag"."id"

  WHERE 
    ("student"."firstname"    ILIKE '%jo%' OR "student"."lastname" ILIKE '%%') AND
    "student"."isInstructor" = TRUE
  ORDER BY "course"."updatedAt" DESC
  LIMIT 20
  OFFSET 0;

/*
Run against PROD on 2021/02/16

Limit  (cost=923.37..923.38 rows=20 width=2066) (actual time=5.610..5.615 rows=20 loops=1)
  ->  Sort  (cost=923.37..923.39 rows=35 width=2066) (actual time=5.608..5.612 rows=20 loops=1)
        Sort Key: course."updatedAt" DESC
        Sort Method: top-N heapsort  Memory: 144kB
        ->  Nested Loop  (cost=4.62..923.19 rows=35 width=2066) (actual time=0.197..4.823 rows=557 loops=1)
              ->  Nested Loop  (cost=4.59..921.56 rows=35 width=1966) (actual time=0.179..4.017 rows=557 loops=1)
                    ->  Nested Loop  (cost=4.54..912.30 rows=37 width=860) (actual time=0.169..2.803 rows=557 loops=1)
                          ->  Hash Join  (cost=4.48..12.08 rows=539 width=16) (actual time=0.130..0.390 rows=557 loops=1)
                                Hash Cond: (course_instructors_student."courseId" = course_tags_course_tag."courseId")
                                ->  Seq Scan on course_instructors_student  (cost=0.00..4.88 rows=627 width=8) (actual time=0.009..0.068 rows=628 loops=1)
                                ->  Hash  (cost=3.15..3.15 rows=382 width=8) (actual time=0.088..0.089 rows=382 loops=1)
                                      Buckets: 1024  Batches: 1  Memory Usage: 23kB
                                      ->  Seq Scan on course_tags_course_tag  (cost=0.00..3.15 rows=382 width=8) (actual time=0.007..0.034 rows=382 loops=1)
                          ->  Index Scan using "PK_3d8016e1cb58429474a3c041904" on student  (cost=0.06..1.67 rows=1 width=844) (actual time=0.004..0.004 rows=1 loops=557)
                                Index Cond: (id = course_instructors_student."studentId")
                                Filter: ("isInstructor" AND (((firstname)::text ~~* '%jonas%'::text) OR ((lastname)::text ~~* '%%'::text)))
                    ->  Index Scan using "PK_bf95180dd756fd204fb01ce4916" on course  (cost=0.05..0.25 rows=1 width=1106) (actual time=0.001..0.001 rows=1 loops=557)
                          Index Cond: (id = course_instructors_student."courseId")
              ->  Index Scan using "PK_6c6a0ad4b5f67db91353e5b2ae1" on course_tag  (cost=0.03..0.05 rows=1 width=100) (actual time=0.001..0.001 rows=1 loops=557)
                    Index Cond: (id = course_tags_course_tag."courseTagId")
Planning Time: 3.619 ms
Execution Time: 5.785 ms

*/