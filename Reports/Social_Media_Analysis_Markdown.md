# Introduction

This case study analyzes synthetic social media usage data to support a "Digital Wellness" application strategy. The goal of this project is to explore the relationship between intensive Instagram usage and user well-being metrics (Stress, Happiness, Sleep) to inform the product roadmap and marketing strategy.

By examining behavioral logs, demographic details, and health metrics from over 1.5 million users, I aim to uncover whether social media usage is primarily a physiological issue (sleep loss) or a psychological one (stress), guiding the development of high-impact features.

This analysis follows the standard analytics process: **Ask, Prepare, Process, Analyze, Share, and Act**.

# Ask

### Business Task
**The goal** is to identify the correlation between usage intensity and mental health to optimize the app's value proposition.

To support this goal, I will analyze user behavior data to quantify the impact of scrolling on stress and sleep. The insights from this analysis will help the Product Team prioritize features (e.g., Sleep Trackers vs. Anxiety Management) based on actual user "need states."

### Key Stakeholders

   *   **Product Strategy Team** – Responsible for the app's feature roadmap.
   *   **Marketing Team** – Responsible for user acquisition and targeting.
   *   **App Users** – Individuals seeking tangible improvements in their digital well-being.

### Success Metrics
1.   Identify key usage patterns and their correlation with health metrics.
2.   Present clear and accurate visualizations of the "Well-being Gap."
3.   Provide at least three actionable recommendations for the product strategy.

# Prepare

## Data Source
The dataset used for this analysis is the **Social Media User Behavior & Lifestyle Dataset**, a synthetic dataset designed to simulate realistic user patterns for the 2025–2026 period. It contains **1,547,896 records**, offering a comprehensive view of demographics, digital habits, and physiological health stats.

> **Note:** This data is 100% synthetic, ensuring no PII (Personally Identifiable Information) risks while providing a statistically robust sample size for segmentation analysis.

## Data Structure
The data was originally split into two relational tables, linked by the unique `User_ID` column:

   *   **Demographics Table:** `instagram_users_lifestyle_raw` (Age, Gender, Stress Score, Sleep Hours, Happiness Score).
   *   **Usage Table:** `instagram_usage_lifestyle_raw` (Daily Minutes, Reels Watched, Sessions per Day).

## ROCCC Assessment
To ensure the data is suitable for analysis, I performed a ROCCC assessment:

| Criterion | Status | Assessment |
| :--- | :--- | :--- |
| **Reliable** | High | 1.55M rows provide a minimal margin of error for statistical segmentation. |
| **Original** | Low | First-party synthetic data generated for simulation; not organic user logs. |
| **Comprehensive** | High | Uniquely links distinct domains (Health + Digital Stats) rarely found in public data. |
| **Current** | High | Simulates 2025–2026 behaviors, ensuring forward-looking insights. |
| **Cited** | High | Released under CC0 Public Domain license. |

## Environment Setup and Data Import

I utilize **Google BigQuery (SQL)** for data cleaning and transformation due to the dataset's volume (>1 million rows), and **Tableau** for the subsequent visualization phases.

# Process

* **Tool Selection:** **SQL (BigQuery)** was utilized for data extraction, cleaning, and joining. Spreadsheet tools (Excel) were ruled out due to row limits.
* **Data Integrity & Cleaning Log:** The following processing steps were executed to resolve data quality issues identified during the "Prepare" phase.

## 1. Integrity Check & Duplicates

* **Logic Applied:**

   *   Verified `COUNT(*)` across both source tables to ensure data completeness.
   *   Checked for duplicates using `COUNT(DISTINCT User_ID)`.
   *   **Result:** 0 Duplicates found.

## 2. Logic Validation & Outlier Removal

**Objective:** Remove synthetic anomalies that do not reflect real human limitations.

* **Logic Applied:**

   *   **Age:** Filtered for users aged **13–100** (Standard platform limits).
   *   **Sleep:** Filtered for `sleep_hours_per_night` between **0 and 24**.
   *   **Usage:** Filtered for `daily_active_minutes_instagram` < 1440 (Minutes in a day).

## 3. Data Transformation (Joining)

**Objective:** Create a single source of truth by merging demographics with usage logs.

* **Logic Applied:**

   *   Performed an `INNER JOIN` on `User_ID`.
   *   Projected only relevant columns (Stress, Happiness, Sleep, Usage) to optimize query performance.

```{r SQL_JOIN_FILTER, eval=FALSE, include=TRUE}
/* CLEANING SAMPLE: JOIN AND FILTER */
CREATE OR REPLACE TABLE `social_media_dataset.cleaned_social_media_dataset` AS
SELECT
  t1.User_ID,
  t1.age,
  t1.gender,
  t1.income_level,
  t1.perceived_stress_score,
  t1.sleep_hours_per_night,
  t1.self_reported_happiness,
  t2.daily_active_minutes_instagram,
  t2.reels_watched_per_day
FROM
  `social_media_dataset.instagram_users_lifestyle_raw` AS t1
INNER JOIN
  `social_media_dataset.instagram_usage_lifestyle_raw` AS t2
ON
  t1.User_ID = t2.User_ID
WHERE
  t1.age BETWEEN 13 AND 100
  AND t1.sleep_hours_per_night BETWEEN 0 AND 24;
```

## 4. Verification & Validation

Post-processing, the following validation checks were run against all clean tables:

   1.   **Row Counts:** Confirmed 1,547,896 rows in the final table.
   2.   **Schema Check:** Verified data types (FLOAT for minutes, INTEGER for scores).

**Summary of the Process Phase**

   *   **Tools Used:** SQL (BigQuery).
   *   **Key Actions:** Merged relational tables, filtered logical outliers, and aggregated features.
   *   **Outcome:** A clean, flat dataset ready for analysis.

# Analyze

First, I calculated the Pearson Correlation Coefficient to identify which health metrics are impacted by usage.

## 1. Statistical Correlation Matrix

First, I examine the distribution of daily steps to understand the baseline activity level of the user base.

| Metric Pair | Correlation Score | Interpretation |
| :--- | :--- | :--- |
| **Usage vs. Stress** | **0.83** | **Strong Positive.** More usage = Much higher stress. |
| **Usage vs. Happiness** | **-0.37** | **Moderate Negative.** More usage = Lower happiness. |
| **Usage vs. Sleep** | **~0.00** | **No Correlation.** Usage has no impact on sleep duration. |

**Insights:**

   *   The data disproves the "Sleep Displacement" hypothesis. Users do not trade sleep for scrolling; they trade mental peace for scrolling.

## 2. The "Well-being Gap" (Segmentation)

To understand how users spend their day, I analyze the breakdown of activity intensity.

I segmented users into "Light", "Moderate", and "Heavy" buckets to visualize the disparity.

Figure 1: Comparison of Stress and Happiness across Usage Tiers

<img width="100%" alt="Figure 1: Well-being Gap" src="https://github.com/user-attachments/assets/c168c095-9bae-467d-88a8-01396c618891" />

**Insights:**

   *   **Heavy Users (>120 mins)** report a stress score of **25.21**, nearly **5x higher** than Light Users (5.07).
   *   Happiness scores drop by **35%** as users move from Light to Heavy usage.

## 3. Generational Stress Trends

Is this a universal problem? I analyzed stress scores across age groups (decades).

Figure 2: Stress and Usage Trends by Age Group

<img width="100%" alt="Figure 2: Age Trends" src="https://github.com/user-attachments/assets/de813c3c-6194-4f04-9a95-b4ebae908387" />

**Insights:**

   *   The problem is age-specific. Both Usage (Line 1) and Stress (Line 2) peak in the **20–30 age bracket** and decline linearly as users get older.
   *   This identifies **Gen Z / Young Millennials** as the primary at-risk population.
   *   
## 4. Demographic Impact

Does gender play a role?

Figure 3: Stress Scores by Gender and Usage Category

<img width="100%" alt="Figure 3: Gender Impact" src="https://github.com/user-attachments/assets/5995e6e8-2fdf-41d3-b38e-0c0981962f02" />

**Insights:**

   *   The correlation is universal. Regardless of gender identity, the trend remains the same: Heavy Usage = High Stress.

# Share

## Key Findings & Insights
Based on the analysis of 1.55 million users, I have identified four key trends that directly impact the product strategy.

###   1. Usage Drives Stress, Not Sleep Loss

   *   **Observation:** There is a 0.83 correlation with Stress, but ~0 correlation with Sleep.
   *   **Implication:** Features focused on "Sleep Health" address a problem that doesn't exist for this user base. The app should pivot to **Mental Health** (Anxiety/Stress).

###   2. The "Heavy User" Cliff

   *   **Observation:** Well-being metrics degrade sharply once a user exceeds **120 minutes** of daily activity.
   *   **Implication:** This specific timestamp (2 hours) is the critical threshold for intervention.

###   3. Youth Vulnerability

   *   **Observation:** Stress scores are highest among users aged **18–29**.
   *   **Implication:** Marketing and UI design should be tailored to this demographic's aesthetic and needs.

###   4. Happiness Deficit

   *   **Observation:** Heavy users are statistically less happy (-0.37 correlation).
   *   **Implication:** The app has an opportunity to market itself as a "Happiness Booster" by helping users moderate their consumption.

# Act

## Recommendations

Based on the data findings, I propose the following actionable strategies for the "Digital Wellness" app:

###   1. Product Pivot: From "Sleep" to "Stress"

   *   **Strategy:** Deprioritize the development of sleep tracking dashboards. Instead, reallocate engineering resources to build **"Anxiety Management"** tools (e.g., Mood Journaling, Guided Breathing).
   *   **Why:** The data proves that sleep duration is stable; stress is the volatile variable that needs managing.

###   2. Feature: The "120-Minute Nudge"

   *   **Strategy:** Implement a soft intervention feature that triggers specifically at the **115-minute mark** of daily usage.
   *   **Mechanism:** A non-intrusive prompt (e.g., "You've been active for nearly 2 hours. Time for a mindful break?") to prevent users from crossing the high-stress threshold.

###   3. Marketing: Target the 18-29 Demographic

   *   **Strategy:** Focus User Acquisition (UA) spend on platforms frequented by Gen Z (TikTok, Instagram).
   *   **Messaging:** "Don't let your feed feed your anxiety." Position the app as a tool for regaining control over digital life, specifically targeting the high-stress young adult segment.

## Limitations

To maintain analytical rigor, it is important to acknowledge the limitations of this case study:

   *   **Synthetic Nature:** The data is 100% synthetic. While it models realistic distributions, it may lack the nuanced, chaotic behavior of organic human users.
   *   **Causality:** The high correlation (0.83) suggests a link, but does not prove causality. Does usage cause stress, or do stressed people use the app to cope?

## Future Work

To refine these recommendations, the team should consider:

   *   **Content Analysis:** Analyze what users are watching (Reels vs. Stories) to see if specific content types are more "toxic" than others.
   *   **Longitudinal Study:** Track a cohort of real users over 6 months to test if reducing usage via the "Nudge" feature actually lowers their cortisol/stress levels.

---
**Report generated on:** `r Sys.Date()`
**Author:** Amartisoaei Robert
