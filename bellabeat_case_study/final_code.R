# Load necessary libraries
library(tidyverse)
library(lubridate)

# ------------------------------------------------------------------
# Description of the Dataset and Objectives of the Analysis
# ------------------------------------------------------------------
# This script analyzes a dataset from Fitabase, which includes information
# about daily activity, calorie consumption, sleep patterns, and weight.
# The objective is to explore relationships among different variables and
# gain insights into patterns of activity, calorie burn, and sleep.

# ------------------------------------------------------------------
# Data Loading
# ------------------------------------------------------------------
# Define the common path prefix
path_prefix <- "Coursera/Capstone/Fitabase Data 4.12.16-5.12.16/"

# Check if files exist before loading
files <- c("dailyActivity_merged.csv", "hourlyCalories_merged.csv", 
           "hourlyIntensities_merged.csv", "sleepDay_merged.csv", 
           "weightLogInfo_merged.csv")
for (file in files) {
  if (!file.exists(paste0(path_prefix, file))) {
    stop(paste0("File not found: ", path_prefix, file))
  }
}

# Load the data
activity <- read.csv(paste0(path_prefix, "dailyActivity_merged.csv"))
calories <- read.csv(paste0(path_prefix, "hourlyCalories_merged.csv"))
intensities <- read.csv(paste0(path_prefix, "hourlyIntensities_merged.csv"))
sleep <- read.csv(paste0(path_prefix, "sleepDay_merged.csv"))
weight <- read.csv(paste0(path_prefix, "weightLogInfo_merged.csv"))

# ------------------------------------------------------------------
# Data Cleaning and Formatting
# ------------------------------------------------------------------
# Format timestamp columns
format_timestamp <- function(data, timestamp_col) {
  # Convert timestamp columns to POSIXct and extract date and time
  data[[timestamp_col]] <- as.POSIXct(data[[timestamp_col]], format="%m/%d/%Y %I:%M:%S %p", tz="UTC")
  data$date <- format(data[[timestamp_col]], format="%Y-%m-%d")
  data$time <- format(data[[timestamp_col]], format="%H:%M:%S")
  return(data)
}

# Apply the formatting function to relevant columns
intensities <- format_timestamp(intensities, "ActivityHour")
calories <- format_timestamp(calories, "ActivityHour")
activity$date <- as.Date(activity$ActivityDate, format="%m/%d/%Y")
sleep <- format_timestamp(sleep, "SleepDay")

# Merge the data frames using 'Id' and 'date' columns
merged_data <- merge(activity, sleep, by=c('Id', 'date'))

# ------------------------------------------------------------------
# Exploratory Data Analysis (EDA)
# ------------------------------------------------------------------
# Calculate summary statistics for various variables
variables <- c("TotalSteps", "Calories", "TotalMinutesAsleep", "TotalTimeInBed", "TotalIntensity")
for (var in variables) {
  print(paste0("Summary Statistics for ", var, ":"))
  print(summary(merged_data[[var]]))
}

# Perform a correlation test between Total Steps and Calories Burned
cor_test <- cor.test(activity$TotalSteps, activity$Calories)
print("Correlation Test between Total Steps and Calories Burned:")
print(cor_test)

# ------------------------------------------------------------------
# Visualization
# ------------------------------------------------------------------
# Total Steps vs. Calories Burned with Hexbin Plot and Regression Line
ggplot(data=activity, aes(x=TotalSteps, y=Calories)) + 
  geom_hex(bins=50, color="white") + 
  geom_smooth(method="lm", se=FALSE, color="red") +
  labs(title="Total Steps vs. Calories Burned", x="Total Steps", y="Calories Burned") +
  theme_minimal()

# Define Activity Level based on Total Steps
merged_data$ActivityLevel <- cut(merged_data$TotalSteps, 
                                 breaks = c(-Inf, 5000, 10000, Inf), 
                                 labels = c("Low", "Medium", "High"))

# Sleep Duration vs. Activity Level with Box Plot
ggplot(data=merged_data, aes(x=ActivityLevel, y=TotalMinutesAsleep, fill=ActivityLevel)) + 
  geom_boxplot() +
  labs(title="Sleep Duration vs. Activity Level", x="Activity Level", y="Total Minutes Asleep") +
  theme_minimal() +
  scale_fill_manual(values=c("Low" = "lightblue", "Medium" = "lightgreen", "High" = "lightcoral"))




# Average Intensity Levels vs. Time with Line Plot and Shading
intensity_avg <- intensities %>%
  group_by(time) %>%
  summarise(avg_intensity = mean(TotalIntensity), se = sd(TotalIntensity) / sqrt(n()))

# Convert 'time' to factor while keeping only the hour part for plotting
intensity_avg$time <- factor(format(strptime(intensity_avg$time, format="%H:%M:%S"), "%H"), levels = sprintf("%02d", 0:23))

# Create the line plot with shading
ggplot(data=intensity_avg, aes(x=time, y=avg_intensity)) + 
  geom_line(group=1, color='darkblue') +
  geom_ribbon(aes(ymin=avg_intensity-se, ymax=avg_intensity+se), alpha=0.2) +
  scale_x_discrete(breaks=sprintf("%02d", 0:23)) +
  theme(axis.text.x = element_text(angle=45, vjust=0.5, hjust=1)) +
  labs(title="Average Intensity Levels vs. Time", x="Time (Hour)", y="Average Intensity") +
  theme_minimal()

# ------------------------------------------------------------------
# Final Summary/Conclusion
# ------------------------------------------------------------------
# Here, summarize the key findings and insights gained from the analysis.
# Discuss any patterns or relationships observed and their implications.



