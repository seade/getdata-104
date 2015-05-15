#
# run_analysys.R
#
# Script that downloads raw data, tidies it up and produces separate tidy
# summary file.
#
# Requirement: This script assumes the following packages have been installed
# prior to execution.
# install.packages("downloader", "dplyr")
#
# Note: Tested on OS X, have tried to be platform neutral, but cannot guarantee
# this will work unchanged on other platforms.

# Clean up previously extracted data
localdata <- "UCI HAR Dataset"
if (file.exists(localdata)) {
        ## Delete the data directory and start afresh
        unlink(localdata, recursive = TRUE)
}

# Only re-download if local zip file is unavailable
localzip <- "UCI_HAR_Dataset.zip"
if (!file.exists(localzip)) {
        library(downloader)

        basezip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        # Retrieve the file
        download(basezip, destfile=localzip)
        # Record the date the fata was downloaded
        dateDownloaded <- date()
}

# Unzip the file
unzip(localzip)

# dplyr functions will be useful here
library(dplyr)
## Note: Use of tbl_df below is only to help during development, it is not necessart in the final version.

# base level data
##featuresRAW <- read.table(file.path(localdata, "features.txt")) # 561 x 2
features <- tbl_df(read.table(file.path(localdata, "features.txt"))) # 561 x 2
activityLabels <- tbl_df(read.table(file.path(localdata, "activity_labels.txt"))) # 6 x 2
# test data
subjecttest <- tbl_df(read.table(file.path(localdata, "test", "subject_test.txt"))) # 2947 x 1
xtest <- tbl_df(read.table(file.path(localdata, "test", "X_test.txt"))) # 2947 x 561
ytest <- tbl_df(read.table(file.path(localdata, "test", "Y_test.txt"))) # 2947 x 1
# train data
subjecttrain <- tbl_df(read.table(file.path(localdata, "train", "subject_train.txt"))) # 7352 x 1
xtrain <- tbl_df(read.table(file.path(localdata, "train", "X_train.txt"))) # 7532 x 561
ytrain <- tbl_df(read.table(file.path(localdata, "train", "Y_train.txt"))) # 7532 x 1

## Advice: Follow the steps in the numbered order

# 1. Merge the training and test sets to create one data set
# 1.a. Merge the rows
subject <- bind_rows(subjecttest, subjecttrain) # 10299 x 1
rm(subjecttest, subjecttrain)
x <- bind_rows(xtest, xtrain) # 10299 x 561
rm(xtest, xtrain)
y <- bind_rows(ytest, ytrain) # 10299 x 1
rm(ytest, ytrain)

# 2. Extract only the measurements on the mean and standard deviation for each measurement
## TODO I think it would be preferable to assign all of the column names then use dplyr's "-" syntax to
## include/exclude columns

##colindexesRAW <- grep("-mean\\(\\)|-std\\(\\)", featuresRAW[,2])
colindexes <- grep("-mean\\(\\)|-std\\(\\)", features$V2) # 66
##colnamesRAW <- as.character(featuresRAW[colindexesRAW,2])
x <- x[,colindexes] # 10299 x 66

# 3. Use descriptive activity names by replacing the activity numbers in y with
#    the activity names in activityLabels
ylabeled <- inner_join(y, activityLabels, by="V1")
rm(y, activityLabels)

# 1.b. Merge the columns, in this case the subject, the activity name and the
#      data in x
subjectyx <- bind_cols(subject, data.frame(ylabeled$V2), x) # 10299 x 68
rm(subject, ylabeled, x)

# 4. Appropriate labels for the data set with desceiptive labels
## Extract the column names we have retained
colnames <- features[colindexes,2] # 66
## Convert from factor to character
colnames$V2 <- as.character(colnames$V2) # 66
# Tidy column names up a little, but keep some semblance to the CodeBook for
# the input data.
colnames$V2 <- sub("\\(\\)", "", colnames$V2) # Brackets are weird
colnames$V2 <- gsub("-", "_", colnames$V2) # Hyphyns are awkward

# Don't forget to cater for the two columns that were added above
colnames <- c("subject", "activity", colnames$V2) # 68
names(subjectyx) <- colnames
rm(features, colindexes, colnames)

# Save the cleaned data
##tbl_df(subjectyx)
write.table(subjectyx, gsub(" ","_", paste(localdata, "cleaned.txt")))

# 5. Create a second independent tidy data set with the average of each variable
#    for each activity and each subject
## Group by activity and subject
grouped <- group_by(subjectyx, subject, activity)
## Compute averages
newtidy <- summarise_each(grouped, funs(mean))
## Update column names to reflect mean: prefixing them with "mean_"
cols <- colnames(newtidy)
cols[-(1:2)] <- paste0("mean_",cols[-(1:2)])
colnames(newtidy) <- cols
## Save data
write.table(newtidy, gsub(" ","_", paste(localdata, "summary.txt")), row.names=FALSE)
