Getting & Cleaning Data Course Project
======================================

The `run_analysis.R` script performs the following functions:

 - downloads & unzips the [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) if it's not already present
 - creates a single data set containing all mean and std_dev observations from both the Training and Test datasets
 - saves that combined data set as `mean_and_std_obvs.csv`
 - calculates the required averages from teh combined data set and saves it to `averages.csv`
