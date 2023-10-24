WITH
retention_weeks
AS
(
WITH
dates AS

(SELECT
user_pseudo_id,
MIN (DATE_TRUNC (subscription_start, WEEK)) AS start_week,
MAX (DATE_TRUNC (subscription_end, WEEK)) AS Last_week,


FROM tc-da-1.turing_data_analytics.subscriptions

GROUP BY user_pseudo_id
ORDER BY start_week)

SELECT
start_week,
SUM (CASE WHEN start_week IS NOT NULL THEN 1 ELSE 0 END) AS user_count,
SUM (CASE WHEN start_week = last_week OR last_week IS NULL THEN 1 ELSE 0 END) AS week_0,
SUM (CASE WHEN (DATE_ADD(start_week, INTERVAL 1 week)) < last_week OR last_week IS NULL THEN 1 ELSE 0 END) AS week_1,
SUM (CASE WHEN (DATE_ADD(start_week, INTERVAL 2 week)) < last_week OR last_week IS NULL THEN 1 ELSE 0 END) AS week_2,
SUM (CASE WHEN (DATE_ADD(start_week, INTERVAL 3 week)) < last_week OR last_week IS NULL THEN 1 ELSE 0 END) AS week_3,
SUM (CASE WHEN (DATE_ADD(start_week, INTERVAL 4 week)) < last_week OR last_week IS NULL THEN 1 ELSE 0 END) AS week_4,
SUM (CASE WHEN (DATE_ADD(start_week, INTERVAL 5 week)) < last_week OR last_week IS NULL THEN 1 ELSE 0 END) AS week_5,
SUM (CASE WHEN (DATE_ADD(start_week, INTERVAL 6 week)) < last_week OR last_week IS NULL THEN 1 ELSE 0 END) AS week_6

FROM dates

GROUP BY
start_week)

SELECT
start_week,
(user_count/user_count) AS cohort_size,
(week_0/user_count) AS week_0,
(week_1/user_count) AS week_1,
(week_2/user_count) AS week_2,
(week_3/user_count) AS week_3,
(week_4/user_count) AS week_4,
(week_5/user_count) AS week_5,
(week_6/user_count) AS week_6,

FROM
retention_weeks
