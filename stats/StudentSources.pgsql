SELECT 
  "student"."active",
  "student"."isInstructor",
  "student"."isStudent" as "isTutor",
  "student"."isProjectCoach",
  "student"."isUniversityStudent",
  "student"."createdAt" as "accountCreated",

  "screening"."knowsCoronaSchoolFrom",
  "screening"."success" as "tutorScreeningSuccess",
  "screening"."createdAt" as "tutorScreeningAt",

  "instructor_screening"."knowsCoronaSchoolFrom",
  "instructor_screening"."createdAt" as "instructorScreeningAt",
  "instructor_screening"."success" as "instructorScreeningSuccess"

  FROM "student"
  LEFT JOIN "screening" ON "screening"."studentId" = "student"."id"
  LEFT JOIN "instructor_screening" ON "screening"."id" = "student"."id"
  
  LIMIT 100;