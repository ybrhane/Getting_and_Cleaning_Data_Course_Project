# Change working directory to the downloaded "UCI HAR Dataset" directory:
setwd("../UCI HAR Dataset")

# Read activity labels
activityLabels <- read.table("activity_labels.txt",header=FALSE,sep=" ")[,2]

# List of all features.
featureNames <- read.table("features.txt",header=FALSE,sep=" ")[,2]

# Read train data 
X_train <- read.table("train/X_train.txt",header=FALSE,sep="")

#Appropriately labels the data set with descriptive variable names.
names(X_train) = featureNames

y_train <- read.table("train/y_train.txt",header=FALSE,sep=" ")
str(y_train)
subject_train <- read.table("train/subject_train.txt",header=FALSE,sep=" ")
names(subject_train) = "subject"

# Extract only the measurements on the mean and standard deviation for each measurement.
X_train = subset(X_train,select=grepl("mean()|std()", featureNames))

# Uses descriptive activity names to name the activities in the data set
names(y_train) = "activityID"
y_train$activityLabel = activityLabels[y_train$activityID]

# Train data
train_data <- cbind(subject_train, y_train, X_train)

# Read test data
X_test <- read.table("test/X_test.txt",header=FALSE,sep="")

#Appropriately labels the data set with descriptive variable names.
names(X_test) = featureNames
y_test <- read.table("test/y_test.txt",header=FALSE,sep=" ")
str(y_test)
subject_test <- read.table("test/subject_test.txt",header=FALSE,sep=" ")
names(subject_test) = "subject"

# Extract only the measurements on the mean and standard deviation for each measurement.
X_test = subset(X_test,select=grepl("mean()|std()", featureNames))

# Uses descriptive activity names to name the activities in the data set
names(y_test) = "activityID"
y_test$activityLabel = activityLabels[y_test$activityID]

# Test data 
test_data <- cbind(subject_test, y_test, X_test)

# Merges the training and the test sets to create one data set.
all_data = rbind(train_data,test_data)

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
all_data_tidy = aggregate(. ~subject + activityLabel, all_data, mean)

# Order by subject and activity label
all_data_tidy = with(all_data_tidy,all_data_tidy[order(subject,activityLabel),])

# Write out tidy data 
write.table(all_data_tidy, file = "tidy_data.txt",quote=FALSE,row.names=FALSE)


