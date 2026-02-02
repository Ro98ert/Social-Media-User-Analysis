# I group the 1.5 million users into 10-year age buckets (20s, 30s, 40s, etc.)

SELECT
  -- Grouping age into decades (23->20, 45->40)
  FLOOR(age/10) * 10 AS age_group,

  ROUND(AVG(daily_active_minutes_instagram), 0) AS avg_daily_minutes,
  ROUND(AVG(perceived_stress_score), 2) AS avg_stress_score,
  ROUND(AVG(self_reported_happiness), 2) AS avg_happiness_score

FROM
  `social-media-analysis-485720.social_media_dataset_raw.cleaned_social_media_dataset`

GROUP BY
  age_group

ORDER BY
  age_group;