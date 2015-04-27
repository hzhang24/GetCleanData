# Course Project of Getting and Cleaning Data

This file describes how run_analysis.R script works.

First, unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename the folder with "UCI HAR Dataset". Make sure the folder "UCI HAR Dataset" and the run_analysis.R script are both in the current working directory.

Secondly, use source("run_analysis.R") command in RStudio.

Third, you will find two output files are generated in the current working directory: merged_data.txt: it contains a data frame called cleanedData with 10299*68 dimension. data_with_means.txt: it contains a data frame called result with 180*68 dimension.

At last, use data <- read.table("data_with_means.txt") command in RStudio to read the file. Since we are required to get the average of each variable for each activity and each subject, and there are 6 activities in total and 30 subjects in total, we have 180 rows with all combinations for each of the 66 features.

Task:
You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Output:
The script outputs data_with_means.txt, the clean independent daset with the average of each variable for each activity and each subject.
