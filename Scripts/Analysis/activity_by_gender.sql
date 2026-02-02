# I check if social media impact Men and Woman differently

SELECT
  gender,
  CASE
    WHEN daily_active_minutes_instagram < 45 THEN 'Light'
    WHEN daily_active_minutes_instagram BETWEEN 45 AND 120 THEN 'Moderate'
    ELSE 'Heavy'
  END AS usage_category,

  ROUND(AVG(perceived_stress_score), 2) AS avg_stress_score

FROM
  `social-media-analysis-485720.social_media_dataset_raw.cleaned_social_media_dataset`

GROUP BY
  gender, usage_category

ORDER BY
  usage_category, gender;