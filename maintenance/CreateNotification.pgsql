/* WARN: This adds a new notification, but does not enable it. Use EnableNotification afterwards */

BEGIN TRANSACTION;

INSERT  INTO "notification" ("id", "description", "recipient", "active", "category", "onActions", "cancelledOnAction", "delay", "interval") VALUES (
    /* ID:*/ 20,  
    /* description: */ 'Instant testemail for student registration',
    /* recipient(User - 0, TEACHER - 1, PARENT - 2): */ 0,
    /* active: */ FALSE,
    /* category: */ '{"test"}',
    /* onActions:*/ '{"student_registration_started"}',
    /* cancelledOnAction:*/ '{}',
    /* delay:*/ NULL,
    /* interval*/ NULL
);

/* COMMIT TRANSACTION; */
ROLLBACK TRANSACTION;