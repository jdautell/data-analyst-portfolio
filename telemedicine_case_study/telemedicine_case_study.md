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
The dataset "Telemedicine Use in the Last 4 Weeks" was sourced from [CDC's website](https://data.cdc.gov/NCHS/Telemedicine-Use-in-the-Last-4-Weeks/h7xa-837u).

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

The dataset was cleaned to exclude null values, ensuring the accuracy and reliability of the analysis. The data was then structured into separate sheets/categories: overall trends for adults and children, state-wise trends, income level trends, age group trends, and statistical analysis.

[Link to clean data here](https://github.com/jdautell/data-analyst-portfolio/blob/main/telemedicine_case_study/clean_telemedicine_dataset.xlsx)

## 4. Analyze

### Key Findings:
- **Telemedicine Adoption Over Time:** The dual-axis line chart displays a dynamic trajectory in telemedicine adoption for both adults and households with children. Both lines follow a similar pattern. There is a pronounced surge in September 2021, punctuated by occasional declines in months like July 2021, January 2022, April 2022, and July 2022. 
- **Telemedicine Usage by Age Group:** Telemedicine adoption seems to rise with age, but the oldest groups, especially those 80 and above, demonstrate greater variability in their usage, as highlighted by a heightened standard deviation.
- **State-wise Analysis:** The east and west coasts of the U.S. exhibit higher telemedicine usage, whereas central America, particularly the less populated or more rural states, shows reduced uptake.
- **Income Level Analysis:** A U-shaped pattern emerges across income brackets, with individuals earning less than $35,000 and those earning more than $200,000 exhibiting above-average telemedicine utilization.
- **Variability in Usage:** Age groups "60 - 69 years" and "70 years and above" displayed higher variability in telemedicine usage, suggesting diverse adoption patterns within these demographics.


![image](https://github.com/jdautell/data-analyst-portfolio/assets/132599194/b30ca2d9-22a9-4e23-84a5-90b40202f7f1)


[Link to my Tableau Dashboard](https://public.tableau.com/app/profile/jordan.dautelle/viz/COVID-19TelemedicineDemographicCaseStudy/Dashboard1) 

## 5. Share

### Interpretations and Recommendations:
- **Pandemic-Driven Telemedicine Growth:** The overarching growth in telemedicine adoption, emphasized by the significant spike in September 2021, indicates the profound impact of the COVID-19 pandemic. It has acted as a catalyst, potentially due to lockdowns, social distancing mandates, or heightened health awareness. As telemedicine becomes an integral healthcare facet, providers should be equipped for this sustained growth and potential future surges, especially in the face of ongoing pandemic challenges.
- **Tailored Strategies for Older Demographics:** The increasing telemedicine trend among older individuals is promising. However, the variability in the oldest age bracket indicates a potential gap in tech familiarity or comfort. Tailored training programs or user-friendly interfaces could be developed to engage this demographic more effectively and ensure they fully benefit from telemedicine services.
- **Geographical Disparities:** The coastal regions, associated with urban centers and higher technological infrastructure, naturally gravitate towards telemedicine. However, the subdued adoption in central America underscores the need to address barriers like limited infrastructure, especially in the wake of the pandemic. Investments in these regions can ensure equitable access, particularly crucial during health crises.
- **Economic Considerations:** The pandemic has affected various income groups differently. While telemedicine offers a solution, it's essential to ensure that its benefits are not limited to specific economic brackets. Policies should aim to make telemedicine equally accessible across all income levels.

## 6. Act

### Strategic Actions for Stakeholders:
- **Healthcare Providers:** Enhance telemedicine platforms to be user-friendly, especially for older age groups.
    - Offer training or tutorials to patients unfamiliar with telemedicine.
- **Policy Makers:** Advocate for improved broadband access in areas with low telemedicine adoption.
    - Consider subsidizing telemedicine services for lower-income demographics.
- **Telemedicine Platforms:** Integrate feedback mechanisms to continually refine and improve the user experience.
    - Collaborate with healthcare providers for tailored solutions catering to diverse patient needs.
- **Public Health Campaigns:** Promote the benefits and accessibility of telemedicine, especially in regions or demographics with lower adoption.

In conclusion, this demographic analysis of telemedicine trends provides a comprehensive overview of adoption patterns during the COVID-19 pandemic. The insights and recommendations derived can guide stakeholders in optimizing telemedicine services for broader and more consistent adoption in the future.
