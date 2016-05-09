# Getting_and_Cleaning_Data_Course_Project

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Analysis pipeline

* Download data from the provided source link to your working directory 
* Download the "run_analysis.R" script file from the repository to your working directory
* Change your directory to the downloaded directory named "UCI HAR Dataset" using `setwd("../UCI HAR Dataset")`
* Run `source("run_analysis.R")` at R prompt to load the script 
* The R script will generate an indepedent tidy data called "tiny_data.txt in your working directory.



