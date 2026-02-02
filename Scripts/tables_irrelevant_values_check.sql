# I check for NULLs and Outliers for Sleep, Stress, and Instagram Usage. Values has 0 error count.

SELECT
  'usage_table' AS table_name,
  COUNT(*) AS error_count
FROM `social-media-analysis-485720.social_media_dataset_raw.instagram_usage_lifestyle_raw`
WHERE
  age < 13 OR age > 100 --Instagram requires age 13+
  OR sleep_hours_per_night < 0 OR sleep_hours_per_night > 24
  OR daily_active_minutes_instagram < 0
  OR daily_active_minutes_instagram > 1440
UNION ALL
SELECT
  'users_table' AS table_name,
  COUNT(*) AS error_count
FROM `social-media-analysis-485720.social_media_dataset_raw.instagram_users_lifestyle_raw`
WHERE
  age < 13 OR age > 100 --Instagram requires age 13+
  OR sleep_hours_per_night < 0 OR sleep_hours_per_night > 24
  OR daily_active_minutes_instagram < 0
  OR daily_active_minutes_instagram > 1440