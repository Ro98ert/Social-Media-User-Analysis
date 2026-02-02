# I use segmentation, categorizing users in "Light", "Moderate", "Heavy"

SELECT
  CASE
    WHEN daily_active_minutes_instagram < 45 THEN 'Light User (<45 mins)'
    WHEN daily_active_minutes_instagram BETWEEN 45 AND 120 THEN 'Moderate User (45-120 mins)'
    ELSE 'Heavy User (120+ mins)'
  END AS usage_category,

  COUNT(*) AS total_users,
  ROUND(AVG(sleep_hours_per_night), 2) AS avg_sleep_hours,
  ROUND(AVG(perceived_stress_score), 2) AS avg_stress_score,
  ROUND(AVG(self_reported_happiness), 2) AS avg_happiness_score

FROM
  `social-media-analysis-485720.social_media_dataset_raw.cleaned_social_media_dataset`
  
GROUP BY
  usage_category
  
ORDER BY
  avg_sleep_hours DESC;