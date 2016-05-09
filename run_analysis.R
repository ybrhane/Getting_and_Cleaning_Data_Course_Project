setwd("UCI HAR Dataset")

# Load necessary packages 
library("reshape2")
library("reshape")

# Links the class labels with their activity name.
activityLabels <- read.table("activity_labels.txt",header=FALSE,sep=" ")[,2]

# List of all features.
featureNames <- read.table("features.txt",header=FALSE,sep=" ")[,2]

X_train <- read.table("train/X_train.txt",header=FALSE,sep="")
dim(X_train)
names(X_train) = featureNames
y_train <- read.table("train/y_train.txt",header=FALSE,sep=" ")
str(y_train)

subject_train <- read.table("train/subject_train.txt",header=FALSE,sep=" ")
dim(subject_train)
names(subject_train) = "subject"

# Extract only the measurements on the mean and standard deviation for each measurement.
X_train = subset(X_train,select=grepl("mean|std", featureNames))


# Map Activity Labels to Activity ID
names(y_train) = "activityID"
y_train$activityLabel = activityLabels[y_train$activityID]

# Train data 
train_data <- cbind(as.data.frame(subject_train), y_train, X_train)

# Test set and Test labels.
X_test <- read.table("test/X_test.txt",header=FALSE,sep="")
dim(X_test)
# 3. Uses descriptive activity names to name the activities in the data set

names(X_test) = featureNames
y_test <- read.table("test/y_test.txt",header=FALSE,sep=" ")
str(y_test)

subject_test <- read.table("test/subject_test.txt",header=FALSE,sep=" ")
dim(subject_test)
names(subject_test) = "subject"

# Extract only the measurements on the mean and standard deviation for each measurement.
X_test = subset(X_test,select=grepl("mean|std", featureNames))

# Map Activity Labels to Activity ID
names(y_test) = "activityID"
y_test$activityLabel = activityLabels[y_test$activityID]

# Test data 
test_data <- cbind(as.data.frame(subject_test), y_test, X_test)

# Merge datasets
all_data = rbind(train_data,test_data)

all_data    = melt(all_data, 
                      id.vars = c("subject", "activityID", "activityLabel"), 
                      measure.vars = colnames(all_data)[!is.element(colnames(all_data),c("subject", "activityID", "activityLabel"))])

all_data = rename(all_data, c(variable = "feature", value = "Measurement"))

all_data_tidy   = dcast(all_data, subject + activityLabel ~ feature, mean)

write.table(all_data_tidy, file = "all_data_tidy.txt")



