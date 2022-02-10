/* All our test users shall have the email test+...@lern-fair.de
   Historically there are also a lot of example.org users though (some of which were created by users) */

SELECT firstname, lastname, email, student.id, active, screening.success, verification IS NULL AS verified FROM student
  LEFT JOIN screening ON screening."studentId" = student.id
  WHERE
    split_part(split_part(email, '@', 2), '.', 1) = 'example' OR 
    email LIKE '%test.corona-school.de' OR 
    email LIKE 'test+%lern-fair.de';

SELECT firstname, lastname, email, id, active, verification IS NULL AS verified FROM pupil
  WHERE 
    split_part(split_part(email, '@', 2), '.', 1) = 'example' OR
    email LIKE '%test.corona-school.de' OR 
    email LIKE 'test+%lern-fair.de';

