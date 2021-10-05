SELECT * FROM "course" WHERE "id" = COURSE_ID;

SELECT * FROM "subcourse" WHERE "courseId" = COURSE_ID;

SELECT "lecture"."createdAt", "lecture"."duration", "lecture"."id", "lecture"."instructorId", "lecture"."start", "lecture"."updatedAt" FROM "lecture"
  INNER JOIN "subcourse" ON "subcourse"."id" = "lecture"."subcourseId"
  WHERE "courseId" = COURSE_ID;
