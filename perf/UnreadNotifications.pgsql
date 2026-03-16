SELECT
    "public"."concrete_notification"."id",
    "public"."concrete_notification"."userId",
    "public"."concrete_notification"."notificationID",
    "public"."concrete_notification"."contextID",
    "public"."concrete_notification"."context",
    "public"."concrete_notification"."attachmentGroupId",
    "public"."concrete_notification"."sentAt",
    "public"."concrete_notification"."state",
    "public"."concrete_notification"."error"
FROM
    "public"."concrete_notification"
WHERE
    (
        "public"."concrete_notification"."userId" = 'pupil/3988'
        AND "public"."concrete_notification"."state" = 4
        AND ("public"."concrete_notification"."id") IN (
            SELECT
                "t0"."id"
            FROM
                "public"."concrete_notification" AS "t0"
                INNER JOIN "public"."notification" AS "j0" ON ("j0"."id") = ("t0"."notificationID")
            WHERE
                (
                    ("j0"."id") IN (
                        SELECT
                            "t1"."id"
                        FROM
                            "public"."notification" AS "t1"
                            INNER JOIN "public"."message_translation" AS "j1" ON ("j1"."notificationId") = ("t1"."id")
                        WHERE
                            (
                                "t1"."id" IS NOT NULL
                            )
                    )
                    AND "t0"."id" IS NOT NULL
                )
        )
        AND (
            NOT ("public"."concrete_notification"."id") IN (
                SELECT
                    "t0"."id"
                FROM
                    "public"."concrete_notification" AS "t0"
                    INNER JOIN "public"."notification" AS "j0" ON ("j0"."id") = ("t0"."notificationID")
                WHERE
                    (
                        "j0"."disabledChannels" @> NULL
                        AND "t0"."id" IS NOT NULL
                    )
            )
        )
        AND "public"."concrete_notification"."sentAt" >= '2026-01-01'
    )
ORDER BY
    "public"."concrete_notification"."sentAt" DESC
LIMIT
    100
OFFSET
    0;

SELECT
    t.schemaname,
    t.tablename,
    c.reltuples::bigint                            AS num_rows,
    pg_size_pretty(pg_relation_size(c.oid))        AS table_size,
    psai.indexrelname                              AS index_name,
    pg_size_pretty(pg_relation_size(i.indexrelid)) AS index_size,
    CASE WHEN i.indisunique THEN 'Y' ELSE 'N' END  AS "unique",
    psai.idx_scan                                  AS number_of_scans,
    psai.idx_tup_read                              AS tuples_read,
    psai.idx_tup_fetch                             AS tuples_fetched
FROM
    pg_tables t
    LEFT JOIN pg_class c ON t.tablename = c.relname
    LEFT JOIN pg_index i ON c.oid = i.indrelid
    LEFT JOIN pg_stat_all_indexes psai ON i.indexrelid = psai.indexrelid
WHERE
    t.tablename = 'concrete_notification'
ORDER BY 1, 2;


CREATE INDEX concrete_notification_search ON concrete_notification ("userId", "sentAt");
