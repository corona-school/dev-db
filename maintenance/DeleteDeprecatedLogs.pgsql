SELECT *
FROM log
WHERE logtype IN ('createdCourseAttendanceLog', 'bbbMeeting');

DELETE FROM log
WHERE logtype IN ('createdCourseAttendanceLog', 'bbbMeeting');