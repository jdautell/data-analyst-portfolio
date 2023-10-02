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
...

## 3. Clean and Process

The dataset was cleaned to exclude null values, ensuring the accuracy and reliability of the analysis. The data was then structured into separate sheets/categories: overall trends, state-wise trends, income level trends, age group trends, and statistical analysis.

[Look at the cleaned data here](#clean_telemedicine_dataset.xlsx) 

*Note: You can replace the `#` with the actual link to the file.*

## 4. Analyze

### Key Findings:
- **Telemedicine Adoption Over Time:** ...
- **Age Group Analysis:** ...
- **State-wise Analysis:** ...
- **Income Level Analysis:** ...
- **Variability in Usage:** ...

[Embed or reference the Python visualizations or provide a link to the Tableau Dashboard](#) 

*Note: You can replace the `#` with the actual link or embed code.*

## 5. Share

### Interpretations and Recommendations:
- **Evolving Healthcare Landscape:** ...
- **Tailored Strategies for Older Demographics:** ...
- **Geographical Disparities:** ...
- **Economic Considerations:** ...

## 6. Act

### Strategic Actions for Stakeholders:
- **Healthcare Providers:** ...
- **Policy Makers:** ...
- **Telemedicine Platforms:** ...
- **Public Health Campaigns:** ...

In conclusion, this demographic analysis of telemedicine trends provides a comprehensive overview of adoption patterns during the COVID-19 pandemic. The insights and recommendations derived can guide stakeholders in optimizing telemedicine services for broader and more consistent adoption in the future.
