-- Telemedicine Trends during COVID-19 Case Study with SQL
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


