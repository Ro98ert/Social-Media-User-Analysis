# I verify the correlation between usage and health
  -- -1.0 = strong negative relationship (more instagram = less sleep)
  -- +1.0 = strong positive relationship (more instagram = more stress)
  -- 0 = no relationship
  
SELECT
  -- More social media = less sleep ?
  CORR(daily_active_minutes_instagram, sleep_hours_per_night) AS corr_usage_vs_sleep,
  
  -- More social media = more stress ?
  CORR(daily_active_minutes_instagram, perceived_stress_score) AS corr_usage_vs_stress,
  
  -- More social media = less happiness ?
  CORR(daily_active_minutes_instagram, self_reported_happiness) AS corr_usage_vs_happiness
  
FROM 
  `social-media-analysis-485720.social_media_dataset_raw.cleaned_social_media_dataset`