# I check the integrity of the tables ensuring it uploaded correctly. Observing that there are ~1.55mil users instead of 1 million listed in the dataset's description.
SELECT
  'usage_table' AS table_name,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT User_ID) AS unique_users
FROM `social-media-analysis-485720.social_media_dataset_raw.instagram_usage_lifestyle_raw`
UNION ALL
SELECT
  'users_table' AS table_name,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT User_ID) AS unique_users
FROM `social-media-analysis-485720.social_media_dataset_raw.instagram_users_lifestyle_raw`
