# I JOIN the two tables and create the final cleaned table for analysis.

CREATE OR REPLACE TABLE `social-media-analysis-485720.social_media_dataset_raw.cleaned_social_media_dataset` AS
SELECT
  -- I use Identifiers & Demographics
  t1.user_id,
  t1.age,
  t1.gender,
  t1.income_level,

  -- I use well-being metrics
  t1.perceived_stress_score,
  t1.sleep_hours_per_night,
  t1.self_reported_happiness,

  -- I use usage metrics
  t2.daily_active_minutes_instagram,
  t2.reels_watched_per_day,
  t2.sessions_per_day
  
FROM 
  `social-media-analysis-485720.social_media_dataset_raw.instagram_users_lifestyle_raw` AS t1
  
INNER JOIN 
  `social-media-analysis-485720.social_media_dataset_raw.instagram_usage_lifestyle_raw` AS t2
  
ON 
  t1.user_id = t2.user_id
  
WHERE
  -- I remove impossible values
  t1.age BETWEEN 13 AND 100
  AND t1.sleep_hours_per_night BETWEEN 0 AND 24;