## Download Zip file to your desire working directory
filesPath <- "F:/Data Science/GettingandCleaningData/Course Project - Getting and Cleaning Data"
setwd(filesPath)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
# Unzip file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## Load Data
test_x <- read.table("X_test.txt")
test_y <- read.table("y_test.txt")
train_x <- read.table("X_train.txt")
train_y <- read.table("y_train.txt")

subject_train <- read.table("subject_train.txt")
subject_test <- read.table("subject_test.txt")

activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

## Analysis
# 1. Merges the training and the test sets to create one data set.
# 1.1 Add column names
names(train_x) <- features$V2
names(test_x) <- features$V2
# 1.2 Merge two sets together
dataset <- rbind(train_x, test_x)

# 2. Extracts only the measurements on the mean and standard deviation 
# for each measurement.
mean_std <- grepl("mean\\(\\)", names(dataset)) | grepl("std\\(\\)", names(dataset))
dataset <- dataset[, mean_std]

# 3. Uses descriptive activity names to name the activities in the data set
# 3.1 Add activity labels
dataset_y <- rbind(train_y, test_y)
dataset <- data.table(activity = dataset_y$V1, dataset)
# 3.2 Add subject
subject <- rbind(subject_train, subject_test)
dataset <- data.table(subjectID = subject$V1, dataset)

# 4. Appropriately labels the data set with descriptive variable names
# Replace numbers in activity with descriptive variable names
library(plyr)
dataset$activity <- mapvalues(dataset$activity, from = c(1:6),
                                                to = c("walking", "walking upstairs", "walking downstairs", 
                                                       "sitting", "standing", "laying"))

# 5. From the data set in step 4, creates a second, independent tidy data set with 
# melt data
melt <- melt(dataset, id = c("subjectID", "activity"))
# reshape data
tidydata <- dcast(melt, subjectID + activity ~ variable, mean)

# Create txt file with tidy dataset
write.table(tidydata, file = "tidydata.txt", row.names = FALSE)