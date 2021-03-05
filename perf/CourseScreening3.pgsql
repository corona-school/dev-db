/* NOTE: This can be run against PROD without precaution */

/* This is more or less what /api/screening/courses does right now when searching for users */

EXPLAIN ANALYZE
    SELECT 
    "public"."student"."id",
    "public"."student"."createdAt",
    "public"."student"."updatedAt",
    "public"."student"."firstname",
    "public"."student"."lastname",
    "public"."student"."active",
    "public"."student"."email",
    "public"."student"."verification",
    "public"."student"."wix_id",
    "public"."student"."wix_creation_date",
    "public"."student"."subjects",
    "public"."student"."msg",
    "public"."student"."phone",
    "public"."student"."verifiedAt",
    "public"."student"."authToken",
    "public"."student"."openMatchRequestCount",
    "public"."student"."feedback",
    "public"."student"."authTokenUsed",
    "public"."student"."authTokenSent",
    "public"."student"."sentScreeningReminderCount",
    "public"."student"."lastSentScreeningInvitationDate",
    "public"."student"."isStudent",
    "public"."student"."isInstructor",
    "public"."student"."newsletter",
    "public"."student"."state",
    "public"."student"."university",
    "public"."student"."module",
    "public"."student"."moduleHours",
    "public"."student"."sentInstructorScreeningReminderCount",
    "public"."student"."lastSentInstructorScreeningInvitationDate",
    "public"."student"."lastUpdatedSettingsViaBlocker",
    "public"."student"."isProjectCoach",
    "public"."student"."wasJufoParticipant",
    "public"."student"."hasJufoCertificate",
    "public"."student"."jufoPastParticipationInfo",
    "public"."student"."jufoPastParticipationConfirmed",
    "public"."student"."isUniversityStudent",
    "public"."student"."openProjectMatchRequestCount",
    "public"."student"."sentJufoAlumniScreeningReminderCount",
    "public"."student"."lastSentJufoAlumniScreeningInvitationDate",
    "public"."student"."registrationSource"
    FROM "public"."student" 
    WHERE (LOWER("public"."student"."firstname") ILIKE '%Jon%' AND LOWER("public"."student"."lastname") ILIKE '%%') LIMIT 20 OFFSET 20;

/*

Run against PROD on 2021/02/19


Limit  (cost=38.49..76.98 rows=20 width=846) (actual time=2.625..4.224 rows=20 loops=1)
  ->  Seq Scan on student  (cost=0.00..1018.12 rows=529 width=846) (actual time=0.114..4.218 rows=40 loops=1)
        Filter: ((lower((firstname)::text) ~~* '%Jon%'::text) AND (lower((lastname)::text) ~~* '%%'::text))
        Rows Removed by Filter: 4062
Planning Time: 0.786 ms
Execution Time: 4.262 ms
*/