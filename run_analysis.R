# ------------------------------------------------------------------------------
# Title: Getting and Cleaning Data class project
# Author: Martin Bontrager
# Date: "June 18, 2015"
# ------------------------------------------------------------------------------
## Load libraries and get files
library(plyr)
library(dplyr)

fileURL <- ("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
download.file(fileURL, destfile = "activity.zip", method="curl")
unzip("activity.zip")
setwd("UCI HAR Dataset/")

# ------------------------------------------------------------------------------
## Read and generate the "Training" data set
# These are the features of the data set and will be used for column headers
features <- read.table("features.txt", colClasses = c(rep("character", 2)))
colHeaders <- features$V2

# Read the training set data
trainSet <- read.table("train/X_train.txt", sep="")
colnames(trainSet) <- colHeaders

# Read the subject information to determine which subject performed the 
# activities
subject <- readLines("train/subject_train.txt")
activity <- readLines("train/y_train.txt")

# Add the "subject" and "activity" columns to the training set
trainSet <- cbind(activity, trainSet)
trainSet <- cbind(subject, trainSet)

# ------------------------------------------------------------------------------
## Read and generate the "Test" data set
testSet <- read.table("test/X_test.txt", sep="")

# Same headers as the training data set
colnames(testSet) <- colHeaders

# Read the subject information to determine which subject performed the 
# activities
subject <- readLines("test/subject_test.txt")
activity <- readLines("test/y_test.txt")
testSet <- cbind(activity, testSet)
testSet <- cbind(subject, testSet)

# ------------------------------------------------------------------------------
# Merge the two sets, and subset the data appropriately so as to label neatly 
# and exclude all measurements but mean and standard deviations.

activityData <- rbind(trainSet, testSet)
activityData$activity <- as.factor(activityData$activity)
rm(testSet, trainSet)

# Map the human-readable activities to the numeric factors
actLabels <- read.table("activity_labels.txt", 
                        colClasses = c(rep("character", 2)))
activityData$activity <- mapvalues(activityData$activity, 
                                   from=actLabels$V1, to=actLabels$V2)

# Change column names to be valid R names:
newNames <- make.names(names=names(activityData), unique=TRUE, allow_ = TRUE)
names(activityData) <- newNames

# Select the columns containing "mean" and "std" as well as the subject and 
# activity columns. 
tidyActivity <- select(activityData, subject, activity, matches("mean|std"))

# ------------------------------------------------------------------------------
# Clean up the data and get ready for processing. 
names(tidyActivity) <- lapply(names(tidyActivity), gsub, pattern = "\\.\\.\\.",
                              replacement = "")
names(tidyActivity) <- lapply(names(tidyActivity), gsub, pattern = "\\.\\.",
                              replacement = "")
names(tidyActivity) <- lapply(names(tidyActivity), gsub, pattern = "\\.$",
                              replacement = "")

# Use data.table for handy manipulations
library(data.table)
library(reshape2)
tidyActivity <- data.table(tidyActivity)

# ------------------------------------------------------------------------------
# Melt the data and use dplyr to get measurement means by subject and by 
# activity

tidyMelt <-  melt(tidyActivity, id.vars = c("subject", "activity"))
tidyGroup <- group_by(tidyMelt, subject, activity, variable)
tidyMeans <- summarise(tidyGroup, mean = mean(value))

# Re-cast the data in a wide frame for presentation and arrange by subject
tidyFinalMeans <- dcast(tidyMeans, subject + activity ~ variable)
tidyFinalMeans$subject <- as.character(tidyFinalMeans$subject)
tidyFinalMeans$subject <- as.numeric(tidyFinalMeans$subject)
tidyFinalMeans$activity <- as.character(tidyFinalMeans$activity)
tidyFinalMeans <- arrange(tidyFinalMeans, subject, activity)

# ------------------------------------------------------------------------------
# Write the ordered, summarized data to a csv file
write.csv(tidyFinalMeans, "summarized_Activity_Data.txt", row.names = FALSE, 
          quote = FALSE)
