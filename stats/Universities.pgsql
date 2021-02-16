SELECT COUNT(*), 'no university' AS university FROM student WHERE university IS NULL;
SELECT COUNT(*), 'has university' AS university FROM student WHERE university IS NOT NULL;

SELECT COUNT(*), university FROM student WHERE university IS NOT NULL GROUP BY university;