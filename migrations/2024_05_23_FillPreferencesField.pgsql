-- MIGRATE PUPIL PREFERENCES THAT HAVE newsletter = FALSE --

UPDATE pupil SET "notificationPreferences" = '{
    "chat": { "email": true, "push": true },
    "survey": { "email": false, "push": false },
    "appointment": { "email": true, "push": true },
    "advice": { "email": false, "push": false },
    "suggestion": { "email": false, "push": false },
    "announcement": { "email": true, "push": true },
    "call": { "email": false, "push": false },
    "news": { "email": false, "push": false },
    "event": { "email": false, "push": false },
    "request": { "email": false, "push": false },
    "alternative": { "email": false, "push": false }
}'::jsonb
WHERE "notificationPreferences" IS NULL AND newsletter = FALSE

-- MIGRATE PUPIL PREFERENCES THAT HAVE newsletter = TRUE --

UPDATE pupil SET "notificationPreferences" = '{
  "chat": { "email": true, "push": true },
  "survey": { "email": true, "push": true },
  "appointment": { "email": true, "push": true },
  "advice": { "email": true, "push": true },
  "suggestion": { "email": true, "push": true },
  "announcement": { "email": true, "push": true },
  "call": { "email": true, "push": true },
  "news": { "email": true, "push": true },
  "event": { "email": true, "push": true },
  "request": { "email": true, "push": true },
  "alternative": { "email": true, "push": true }
}'::jsonb
WHERE "notificationPreferences" IS NULL AND newsletter = TRUE

-- MIGRATE STUDENT PREFERENCES THAT HAVE newsletter = FALSE --

UPDATE student SET "notificationPreferences" = '{
    "chat": { "email": true, "push": true },
    "survey": { "email": false, "push": false },
    "appointment": { "email": true, "push": true },
    "advice": { "email": false, "push": false },
    "suggestion": { "email": false, "push": false },
    "announcement": { "email": true, "push": true },
    "call": { "email": false, "push": false },
    "news": { "email": false, "push": false },
    "event": { "email": false, "push": false },
    "request": { "email": false, "push": false },
    "alternative": { "email": false, "push": false }
}'::jsonb
WHERE "notificationPreferences" IS NULL AND newsletter = FALSE

-- MIGRATE STUDENT PREFERENCES THAT HAVE newsletter = TRUE --

UPDATE student SET "notificationPreferences" = '{
  "chat": { "email": true, "push": true },
  "survey": { "email": true, "push": true },
  "appointment": { "email": true, "push": true },
  "advice": { "email": true, "push": true },
  "suggestion": { "email": true, "push": true },
  "announcement": { "email": true, "push": true },
  "call": { "email": true, "push": true },
  "news": { "email": true, "push": true },
  "event": { "email": true, "push": true },
  "request": { "email": true, "push": true },
  "alternative": { "email": true, "push": true }
}'::jsonb
WHERE "notificationPreferences" IS NULL AND newsletter = TRUE

