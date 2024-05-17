/* AUTOMATIC PROMOTIONS */

INSERT INTO subcourse_promotion ("createdAt", "type", "subcourseId")
SELECT COALESCE(subcourse."publishedAt", NOW()), 'system', subcourse.id FROM subcourse WHERE published = TRUE

/* INSTRUCTOR PROMOTIONS */

INSERT INTO subcourse_promotion ("createdAt", "type", "subcourseId")
SELECT COALESCE(subcourse."updatedAt", NOW()), 'instructor', subcourse.id FROM subcourse WHERE published = TRUE AND "alreadyPromoted" = TRUE