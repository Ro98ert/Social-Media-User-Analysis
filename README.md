# Social Media Analysis: Digital Well-Being Case Study

## Project Summary
This project analyzes synthetic Instagram usage and lifestyle data to explore how social media intensity relates to user well-being. The goal is to identify patterns in stress, happiness, and sleep that could inform feature ideas for a digital wellness application.

## Business Question
How is intensive Instagram usage associated with user well-being, and which user segments appear most affected in this dataset?

## Dataset
The analysis uses a synthetic dataset from Kaggle containing over 1 million user records. The data combines:
- social media usage metrics
- demographic attributes
- self-reported well-being indicators

Because the dataset is synthetic, the findings should be interpreted as directional rather than representative of real-world user behavior.

## Tools Used
- **Google BigQuery / SQL** — data cleaning, joining, filtering, and analysis
- **Tableau Public** — dashboard design and visual communication

## Project Workflow
The project followed a structured analytics process:
- defined the business task
- reviewed the dataset structure and suitability
- cleaned and joined the source tables
- analyzed relationships between usage intensity and well-being metrics
- built visualizations to communicate the results
- translated the findings into product recommendations

## Repository Contents

### 1. SQL Processing
**Location:** [`Scripts/Process/`](./Scripts/Process/)

Includes:
- table integrity checks
- data cleaning logic
- validation of logical ranges
- creation of the cleaned analysis table

Key files:
- [`create_new_clean_table.sql`](./Scripts/Process/create_new_clean_table.sql)
- [`tables_integrity_check.sql`](./Scripts/Process/tables_integrity_check.sql)
- [`tables_irrelevant_values_check.sql`](./Scripts/Process/tables_irrelevant_values_check.sql)

### 2. SQL Analysis
**Location:** [`Scripts/Analysis/`](./Scripts/Analysis/)

Includes:
- correlation analysis
- usage segmentation
- age-based analysis
- gender-based comparisons

Key files:
- [`usage_health_correlation.sql`](./Scripts/Analysis/usage_health_correlation.sql)
- [`users_categorization.sql`](./Scripts/Analysis/users_categorization.sql)
- [`users_age_grouping.sql`](./Scripts/Analysis/users_age_grouping.sql)
- [`activity_by_gender.sql`](./Scripts/Analysis/activity_by_gender.sql)

### 3. Reports
**Location:** [`Reports/`](./Reports/)

Available outputs:
- [`Social_Media_Analysis.pdf`](./Reports/Social_Media_Analysis.pdf)
- [`Social_Media_Analysis_Markdown.md`](./Reports/Social_Media_Analysis_Markdown.md)

### 4. Charts
**Location:** [`Charts/`](./Charts/)

Included visuals:
- [`stress_vs_happiness.png`](./Charts/stress_vs_happiness.png)
- [`age_trends.png`](./Charts/age_trends.png)
- [`gender_usage.png`](./Charts/gender_usage.png)
- [`usage_buckets.png`](./Charts/usage_buckets.png)
- [`usage_category.png`](./Charts/usage_category.png)
- [`usage_correlation.png`](./Charts/usage_correlation.png)

## Key Findings
- Higher Instagram usage is associated with higher reported stress.
- Higher usage is also associated with lower self-reported happiness.
- Sleep duration showed little to no relationship with usage intensity in this dataset.
- Younger users showed higher usage and higher stress levels than older age groups.
- The relationship between usage and stress appeared consistent across gender groups.

## Data Source
- Dataset: [Social Media User Analysis Data](https://www.kaggle.com/datasets/rockyt07/social-media-user-analysis)

The analysis uses publicly available Cyclistic (Divvy) trip data. Raw source files are not included in this repository due to size constraints. The SQL scripts assume the original data has already been loaded into a database environment.

## Limitations
This project is based on synthetic data, so the results should not be treated as evidence of real-world causality. The analysis identifies patterns and correlations, not confirmed behavioral effects.

## Notes
AI tools were used selectively for brainstorming, editing, and improving documentation clarity. All analysis logic, SQL/R workflows, interpretation, and final conclusions were reviewed and validated by me.
