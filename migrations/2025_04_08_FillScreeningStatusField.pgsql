-- POPULATE status column in the INSTRUCTOR SCREENING table
UPDATE instructor_screening
SET "status" = CASE
    WHEN success THEN '1'::student_screening_status_enum
    ELSE '2'::student_screening_status_enum
END;

-- POPULATE status column in the INSTRUCTOR SCREENING table
UPDATE screening
SET "status" = CASE
    WHEN success THEN '1'::student_screening_status_enum
    ELSE '2'::student_screening_status_enum
END;