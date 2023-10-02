# Demographic Analysis of Telemedicine Trends: A Case Study

## 1. Ask

### Objective:
To understand the demographic trends in telemedicine usage, especially during the time frame of the COVID-19 pandemic.

#### Key Questions:
- How has telemedicine usage evolved over time?
- Are there noticeable differences in telemedicine adoption across age groups?
- How does telemedicine usage vary geographically across states?
- Does income level influence telemedicine adoption?
- Which age groups show more variability in their telemedicine usage patterns?

## 2. Prepare or Collect Data

### Data Source:
The dataset "Telemedicine Use in the Last 4 Weeks" was sourced from CDC's website.

### SQL Extraction:
SQL was employed to filter and aggregate the data from the source, focusing on indicators related to telemedicine usage. Specific queries looked at average usage over time, by state, by age group, and by income level. Further, statistical measures like variance and standard deviation were extracted for a deeper dive into the consistency of usage patterns.

```sql
-- Calculate the average telemedicine usage for each time period for adults
SELECT
    Time_Period_Start_Date,
    Time_Period_End_Date,
    AVG(Value) as Average_Usage
FROM `firstever-sandbox-project.telemedicine_use.telemedicine_data`
WHERE Indicator = 'Adults Who Had Appointment with Health Professional Over Video or Phone, Last 4 Weeks'
    AND Value IS NOT NULL  -- Exclude rows with null Value
GROUP BY Time_Period_Start_Date, Time_Period_End_Date
ORDER BY Time_Period_Start_Date;
```
```sql
-- Calculate the average telemedicine usage for each time period for households with children
SELECT
    Time_Period_Start_Date,
    Time_Period_End_Date,
    AVG(Value) as Average_Usage
FROM `firstever-sandbox-project.telemedicine_use.telemedicine_data`
WHERE Indicator = 'Households With Children Where Any Child Had Appointment with Health Professional Over Video or Phone, Last 4 Weeks'
    AND Value IS NOT NULL  -- Exclude rows with null Value
GROUP BY Time_Period_Start_Date, Time_Period_End_Date
ORDER BY Time_Period_Start_Date;
```
```sql
-- Investigate telemedicine utilization by different age groups
SELECT
    `Subgroup` as Age_Group,
    AVG(Value) as Average_Usage
FROM `firstever-sandbox-project.telemedicine_use.telemedicine_data`
WHERE `Group` = 'By Age'
    AND (Indicator = 'Adults Who Had Appointment with Health Professional Over Video or Phone, Last 4 Weeks'
        OR Indicator = 'Households With Children Where Any Child Had Appointment with Health Professional Over Video or Phone, Last 4 Weeks')
    AND Value IS NOT NULL  -- Exclude rows with null Value
GROUP BY `Subgroup`
ORDER BY `Subgroup`;
```
```sql
-- Analyze trends in telemedicine usage over time for different age groups
SELECT
    Time_Period_Start_Date,
    `Subgroup` as Age_Group,
    AVG(Value) as Average_Usage
FROM `firstever-sandbox-project.telemedicine_use.telemedicine_data`
WHERE `Group` = 'By Age'
    AND (Indicator = 'Adults Who Had Appointment with Health Professional Over Video or Phone, Last 4 Weeks'
        OR Indicator = 'Households With Children Where Any Child Had Appointment with Health Professional Over Video or Phone, Last 4 Weeks')
    AND Value IS NOT NULL  -- Exclude rows with null Value
GROUP BY Time_Period_Start_Date, `Subgroup`
ORDER BY Time_Period_Start_Date, `Subgroup`;
```
```sql
-- Perform statistical analysis by calculating the variance and standard deviation for telemedicine usage by age group
SELECT
    `Subgroup` as Age_Group,
    VAR_SAMP(Value) as Variance,
    STDDEV_SAMP(Value) as Standard_Deviation
FROM `firstever-sandbox-project.telemedicine_use.telemedicine_data`
WHERE `Group` = 'By Age'
  AND (Indicator = 'Adults Who Had Appointment with Health Professional Over Video or Phone, Last 4 Weeks'
    OR Indicator = 'Households With Children Where Any Child Had Appointment with Health Professional Over Video or Phone, Last 4 Weeks')
GROUP BY `Subgroup`
ORDER BY `Subgroup`;
```
```sql
-- Investigate telemedicine utilization by different States
SELECT
    `State`,
    AVG(Value) as Average_Usage
FROM `firstever-sandbox-project.telemedicine_use.telemedicine_data`
WHERE (Indicator = 'Adults Who Had Appointment with Health Professional Over Video or Phone, Last 4 Weeks'
    OR Indicator = 'Households With Children Where Any Child Had Appointment with Health Professional Over Video or Phone, Last 4 Weeks')
    AND `State` IS NOT NULL
GROUP BY `State`
ORDER BY `State`;
```
```sql
-- Investigate telemedicine utilization by different income levels
SELECT
    `Subgroup` as Income_Level,
    AVG(Value) as Average_Usage
FROM `firstever-sandbox-project.telemedicine_use.telemedicine_data`
WHERE (Indicator = 'Adults Who Had Appointment with Health Professional Over Video or Phone, Last 4 Weeks'
    OR Indicator = 'Households With Children Where Any Child Had Appointment with Health Professional Over Video or Phone, Last 4 Weeks')
    AND `Subgroup` LIKE '%$%'
GROUP BY `Subgroup`
ORDER BY `Subgroup`;
```

## 3. Clean and Process

The dataset was cleaned to exclude null values, ensuring the accuracy and reliability of the analysis. The data was then structured into separate sheets/categories: overall trends, state-wise trends, income level trends, age group trends, and statistical analysis.

[Look at the cleaned data here]([#clean_telemedicine_dataset.xlsx](https://github.com/jdautell/data-analyst-portfolio/blob/main/telemedicine_case_study/clean_telemedicine_dataset.xlsx)) 

## 4. Analyze

### Key Findings:
- **Telemedicine Adoption Over Time:** Telemedicine usage witnessed an upward trajectory, especially from early 2021. This is likely influenced by the progression of the pandemic and the shift in healthcare approach.
- **Age Group Analysis:** Older age groups (60+ years) consistently showed higher telemedicine adoption compared to younger age groups. The risk associated with COVID-19 for older individuals possibly influenced this trend.
- **State-wise Analysis:** Telemedicine adoption displayed variability across states. Specific states exhibited higher average telemedicine usage, possibly due to more severe pandemic impacts or proactive state healthcare policies.
- **Income Level Analysis:** Lower income groups reported higher telemedicine usage compared to higher income groups. This could indicate that telemedicine served as an accessible healthcare option during economic challenges exacerbated by the pandemic.
- **Variability in Usage:** Age groups "60 - 69 years" and "70 years and above" displayed higher variability in telemedicine usage, suggesting diverse adoption patterns within these demographics.

[Link to my Tableau Dashboard](https://public.tableau.com/app/profile/jordan.dautelle/viz/COVID-19TelemedicineDemographicCaseStudy/Dashboard1) 

## 5. Share

### Interpretations and Recommendations:
- **Evolving Healthcare Landscape:** The rising trend in telemedicine adoption underscores its growing significance in the healthcare sector. Providers should invest in enhancing the quality, accessibility, and breadth of telemedicine services.
- **Tailored Strategies for Older Demographics:** Given the higher adoption and variability among older age groups, healthcare providers should consider offering additional support, training, or awareness campaigns to ensure consistent access.
- **Geographical Disparities:** States with lower telemedicine adoption might benefit from policy interventions, infrastructure investments, and awareness campaigns to boost accessibility.
- **Economic Considerations:** With lower income groups showing higher telemedicine usage, it's crucial to ensure affordable telemedicine services, especially during economic downturns.

## 6. Act

### Strategic Actions for Stakeholders:
- **Healthcare Providers:** Enhance telemedicine platforms to be user-friendly, especially for older age groups.
Offer training or tutorials to patients unfamiliar with telemedicine.
- **Policy Makers:** Advocate for improved broadband access in areas with low telemedicine adoption.
Consider subsidizing telemedicine services for lower-income demographics.
- **Telemedicine Platforms:** Integrate feedback mechanisms to continually refine and improve the user experience.
Collaborate with healthcare providers for tailored solutions catering to diverse patient needs.
- **Public Health Campaigns:** Promote the benefits and accessibility of telemedicine, especially in regions or demographics with lower adoption.

In conclusion, this demographic analysis of telemedicine trends provides a comprehensive overview of adoption patterns during the COVID-19 pandemic. The insights and recommendations derived can guide stakeholders in optimizing telemedicine services for broader and more consistent adoption in the future.
