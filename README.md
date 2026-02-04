# Social Media Analysis: Digital Well-being Case Study

This case study analyzes a dataset of over **1,000,000 synthetic user profiles** to understand the relationship between social media usage (specifically Instagram) and personal well-being metrics. The goal is to provide data-driven recommendations for a "Digital Wellness" application looking to develop features that help users disconnect.

By examining usage logs, demographic data, and health metrics (stress, sleep, happiness), I aim to quantify the psychological cost of screen time and identify vulnerable user segments.

This analysis follows the standard analytics process: **Ask, Prepare, Process, Analyze, Share, and Act**.

# Ask

### Business Task
The **"Digital Wellness" client** aims to identify the relationship between intensive social media usage and personal well-being.

To support this, I will analyze user data to determine if social media displaces sleep or primarily impacts mental health. The insights will be used to provide data-driven recommendations for app features and marketing strategies.

### Key Stakeholders
* **Primary:** The Product Team at the "Digital Wellness" client.
* **Secondary:** The app users (seeking to improve mental health).

### Success Metrics
1.  Identify key usage patterns and behavioral differences among users.
2.  Present clear and accurate visualizations of activity and habits.
3.  Provide at least three actionable recommendations for the product strategy.

# Prepare

## Data Source
The dataset used is `instagram_usage_lifestyle_1million.csv` obtained from **Kaggle**. It contains **1,000,000+ rows** representing fully synthetic user profiles that realistically simulate Instagram usage patterns combined with detailed demographic, lifestyle, and health attributes.

> **Note:** All data is **100% synthetic**, generated using statistical distributions for the 2025-2026 period. It mimics real-world correlations but contains no PII (Personally Identifiable Information).

## Data Structure
The analysis focuses on two distinct data domains merged for this study:
* **Usage Drivers (Input):** `daily_active_minutes_instagram`, `sessions_per_day`, `reels_watched_per_day`.
* **Well-being Indicators (Outcome):** `perceived_stress_score`, `self_reported_happiness`, `sleep_hours_per_night`.
* **Demographics:** `age`, `gender`.

## ROCCC Assessment
To ensure the data is suitable for analysis, I performed a ROCCC assessment:

| Criterion | Status | Assessment |
| :--- | :--- | :--- |
| **Reliable** | High | Contains 1M+ rows, reducing the margin of error for statistical patterns. |
| **Original** | Low | First-party synthetic dataset, not real user data. |
| **Comprehensive** | High | Links distinct domains (health stats like blood pressure with digital stats like reels watched) rarely found in public data. |
| **Current** | High | Simulates the 2025-2026 period, making it forward-looking. |
| **Cited** | High | Released under CC0 Public Domain license. |

# Process

**Tool Selection:** I selected **Google BigQuery (SQL)** as the primary tool for data processing due to the dataset size (1M+ rows). Spreadsheet applications would have faced performance limitations.

## Data Integration & Cleaning Strategy
The raw data was split into demographics and usage logs. I performed an `INNER JOIN` on `User_ID` to create a single source of truth.

During processing, I applied specific filters to remove logical outliers likely caused by synthetic generation errors:
1.  **Age Validation:** Filtered for users aged 13 to 100.
2.  **Physiological Validation:** Filtered sleep hours to the logical range of 0 to 24.
3.  **Usage Limits:** Ensured daily active minutes did not exceed 1,440.

### SQL Documentation
The following query was used to clean, join, and create the final analysis table:

```SQL
/* Step 1: Join Demographics (t1) with Usage (t2)
Step 2: Filter for logical data ranges 
Step 3: Create a permanent table for analysis
*/

CREATE OR REPLACE TABLE social_media_dataset.cleaned_social_media_data AS
SELECT
    -- Identifiers & Demographics
    t1.User_ID,
    t1.age,
    t1.gender,
    t1.income_level,
    -- Well-being Metrics (Target Variables)
    t1.perceived_stress_score,
    t1.sleep_hours_per_night,
    t1.self_reported_happiness,
    -- Usage Metrics (Input Variables)
    t2.daily_active_minutes_instagram,
    t2.reels_watched_per_day,
    t2.sessions_per_day
FROM
    social_media_dataset.instagram_users_lifestyle_raw AS t1
INNER JOIN
    social_media_dataset.instagram_usage_lifestyle_raw AS t2
ON
    t1.User_ID = t2.User_ID
WHERE
    -- Filter outliers
    (t1.age BETWEEN 13 AND 100)
    AND (t1.sleep_hours_per_night BETWEEN 0 AND 24);
```

**Outcome:** The query successfully verified the schema and created `cleaned_social_media_dataset` for the analysis phase.

# Analyze

I utilized BigQuery SQL to perform statistical correlation and segmentation analysis. The primary objective was to quantify the relationship between **Usage Intensity** and **User Well-being**.

### 1. Statistical Correlation

I calculated the Pearson Correlation Coefficient to measure impact:

* **Stress (0.83):** Strong positive correlation. As usage increases, stress almost universally increases.
* **Happiness (-0.37):** Moderate negative correlation.
* **Sleep (~0.00):** No significant correlation.

**Key Insight:** The "Sleep Myth" is disproven. Social media does not significantly steal sleep time; instead, it negatively impacts the mental state while awake.

### 2. User Segmentation

To make the data actionable, I segmented users into three categories using SQL:

```SQL
CASE
    WHEN daily_active_minutes_instagram < 45 THEN 'Light User (<45 mins)'
    WHEN daily_active_minutes_instagram BETWEEN 45 AND 120 THEN 'Moderate User (45-120 mins)'
    ELSE 'Heavy User (120+ mins)'
END AS usage_category
```

**Results:**

* **Heavy Users (120+ mins):** Reported an average Stress Score of **25.21**, nearly **5x higher** than Light Users.
* **Light Users (<45 mins):** Reported the highest Happiness Score (7.61).
* **The Sleep Constant:** All three groups averaged exactly 7.0 hours of sleep.

### 3. Demographic Trends

I grouped users by decade to identify at-risk populations.

* **Trend:** Both usage and stress peak in the **20-30 age** bracket and steadily decline as users age.
* **Gender:** The stress correlation holds true across all gender identities; this is a universal issue.

# Share

To effectively communicate these findings, I developed a dashboard using **Tableau Public**. The visualization strategy focused on moving from the "What" (Usage Impact) to the "Who" (Demographics).

[Link to Tableau Dashboard]

### Visual 1: The "Well-being Gap"

* **Objective:** Visually prove the inverse relationship between usage and well-being.
* **Insight:** A clustered bar chart reveals a striking "X" pattern—as usage bars grow taller, happiness bars shrink.

### Visual 2: Generational Stress Trends

* **Objective:** Determine if "Digital Stress" is age-specific.
* **Insight:** A dual-axis line chart shows a clear downward slope, identifying young adults (18-29) as the primary vulnerable population.

### Visual 3: Demographic Impact by Gender

* **Objective: Ensure recommendations address the correct audience.
* **Insight:** Confirms that stress effects are consistent across genders, suggesting a universal solution rather than gender-specific features.

# Act
Based on the insights (0.83 Stress Correlation, Age-specific trends), I propose a three-pillar strategy for the "Digital Wellness" application:

### 1. Pivot from "Sleep" to "Stress"

* **Observation:** Sleep duration remains constant (~7.0 hours) across all usage tiers.
* **Recommendation:** Deprioritize "Sleep Tracking" features. Instead, reallocate resources to build "**Anxiety Management**" and "**Mood Journaling**" tools. Position the app as a mental health companion, not a sleep aid.

### 2. The "120-Minute" Intervention

* **Observation:** The sharpest decline in well-being occurs in the "Heavy User" segment (120+ minutes/day).
* **Recommendation:** Implement a "**Wellness Nudge**" feature. Rather than a generic limit, trigger a soft intervention (e.g., a breathing exercise prompt) at the **115-minute mark**, just before the user crosses into the high-risk threshold.

### 3. Targeted Demographic Marketing

* **Observation:** Stress levels peak in the 20-30 age bracket.
* **Recommendation:** Focus marketing spend and user acquisition strategies on the **18-29 demographic**. This segment has the highest "need state" for a digital wellness solution.

# Next Steps

To refine the product roadmap further, I recommend:

1. **Content Analysis:** Compare Passive Consumption (Reels) vs. Active Engagement to see if one is more toxic.
2. **Longitudinal Study:** A 6-month study to determine causality (does reducing usage actually lower stress?).
3. **A/B Testing:** Roll out the "120-Minute Nudge" to a beta group to measure churn reduction.

**Author:** Amartisoaei Robert **Date:** 2026-02-04