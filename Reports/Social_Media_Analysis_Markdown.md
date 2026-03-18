# Social Media Analysis: Digital Well-Being Case Study

## Project Overview
This project explores the relationship between Instagram usage intensity and user well-being using a large synthetic dataset. The analysis focuses on whether heavier usage is associated with changes in reported stress, happiness, and sleep, and how these patterns vary across demographic groups.

## 1. Business Task
The objective is to identify whether intensive social media usage is associated with lower well-being and to translate those findings into practical ideas for a digital wellness application.

## 2. Data Source
The dataset used for this project is a synthetic social media behavior and lifestyle dataset designed to simulate realistic usage patterns for the 2025–2026 period.

It includes:
- demographic attributes
- Instagram usage metrics
- self-reported stress, happiness, and sleep indicators

The data was originally split into two tables linked by `User_ID`:
- **Demographics table**
- **Usage table**

Because the dataset is synthetic, it is useful for analytical practice and segmentation work, but not for drawing real-world causal conclusions.

## 3. Data Preparation
The analysis was conducted primarily in **Google BigQuery (SQL)**.

Main preparation steps:
- reviewed the structure of both source tables
- checked for duplicate `User_ID` values
- joined demographics and usage data using `INNER JOIN`
- filtered records to logical ranges for age, sleep hours, and usage time
- selected the variables most relevant to the business question

Example cleaning rules:
- age between 13 and 100
- sleep hours between 0 and 24
- daily active minutes below the number of minutes in a day

The result was a clean analysis table ready for correlation and segmentation analysis.

## 4. Analysis Approach
The project focused on three main questions:
1. Is heavier Instagram usage associated with stress, happiness, or sleep?
2. Do these relationships differ across user segments?
3. Which groups appear most relevant for feature design or targeting?

To answer these questions, I used:
- correlation analysis
- usage-based segmentation
- demographic grouping by age and gender

## 5. Key Findings

### Correlation Patterns
- Usage intensity showed a **strong positive correlation** with perceived stress.
- Usage intensity showed a **moderate negative correlation** with self-reported happiness.
- Usage intensity showed **little to no correlation** with sleep duration in this dataset.

### User Segmentation
Users were grouped into light, moderate, and heavy usage categories based on daily active minutes.

This segmentation showed that:
- heavy users reported the highest stress levels
- lighter users reported higher happiness levels
- sleep remained relatively stable across usage groups

### Demographic Trends
- higher usage and higher stress were concentrated in younger age groups
- the usage-stress pattern appeared across gender groups rather than being limited to one segment

## 6. Recommendations
Based on the patterns observed in this dataset, the following ideas could be explored for a digital wellness product:

1. **Prioritize stress-related features**  
   Since stress showed the strongest relationship with usage intensity, features such as mood check-ins, guided breathing, reflective prompts, or short reset exercises may be more relevant than sleep-focused tools.

2. **Test usage-based break nudges**  
   If heavier usage is associated with lower well-being, the product could test prompts that encourage users to pause after extended periods of activity. These interventions should be lightweight and non-intrusive.

3. **Focus early testing on younger adult users**  
   Younger age groups showed higher usage and higher stress in this analysis, making them a reasonable starting segment for product testing and messaging.

4. **Position the app around self-awareness rather than restriction**  
   Since the analysis suggests a relationship with stress and happiness rather than sleep loss, the product may be better positioned as a tool for mindful use and emotional awareness rather than strict screen-time control.

## 7. Limitations
This case study has several important limitations:
- the dataset is fully synthetic
- correlation does not establish causation
- self-reported well-being measures may not reflect clinical outcomes
- the analysis does not include context about content type, intent, or offline factors that may influence stress

## 8. Future Work
Possible next steps include:
- comparing passive and active forms of platform use
- testing whether specific activity types are more strongly associated with stress
- validating the same questions on real-world or longitudinal data
- exploring whether repeated high-usage patterns are concentrated within specific user segments