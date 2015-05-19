## Coursera Getting and Cleaning Data (getdata-104) Course Project.

The provided data ("UCI_HAR_Dataset_summary.txt") is a cleaned up and summarized version of the _Human Activity Recognition Using Smartphones Dataset (Version 1.0)_ data set obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip as documented at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  The cleaning follows the principles outlined in Hadley Wickham's _Tidy Data_ paper available at http://vita.had.co.nz/papers/tidy-data.pdf

Details of the fields in the source data is included in the data set as the file "features_info.txt"

The script "run_analysys.R" processes the data as follows:
* The training data ("X_train.txt", 7,532 observations) and the test data ("X_test.txt", 2,947 observations) are merged together to produce a dataset of 10,299 observations.
* Variables other than those that provided _mean_ and _standard deviation_ were discarded from the combined data set, reducing the number of variables from 561 to 66.  This was achieved by matching the column indexes to those produced by querying the variable names contained in "features.txt" matched against the regular expression _"-mean\\(\\)|-std\\(\\)"_.  The same column filtering was applied against the data read in from "features.txt" to provide the variable names to be applied in a subsequent step.
* The corresponding _subject_ data ("subject_train.txt" & "subject_test.txt") and the activity data ("Y_train.txt" & "Y_test.txt") were merged correspondingly before being joined to the combined observation data set to produce a data set with 10,299 observations for 68 variables commencing with _subject_ and _activity_.
* Finally, the variable names retained from processing "features.txt" are processed to replace hyphens with underscores and remove brackets _()_ (making them more tolerable as R column names) before they were then applied to the cleaned up data set.
* The result of the above processing is written out as "UCI_HAR_Dataset_cleaned.txt"
* The cleaned data is then grouped by _subject_ and _activity_ with mean values produced for all variables for each of these.  The variable names in the summary data are prefixed by "mean_" to reflect this and the data set is then saved as "UCI_HAR_Dataset_summary.txt" (with _row.names=FALSE_)

A list of the variable names in the _summary_ data set follows.  The first two variables, _subject_ and _activity_, contain the "subject_train.txt"/"subject_test.txt" and "Y_train.txt"/"Y_test.txt" data respectively.  The remaining columns contain the per _subject_ and _activity_ mean values of the _mean_ and _std_ columns in the cleaned data set.  To map the variable names to the underlying data:
* remove the "mean_" prefix
* replace underscores ("\_") with hyphens ("-")
* re-insert a pair of brackets ("()") after the last occurrence of _mean_ or _std_

[1] "subject"                        "activity"                       "mean_tBodyAcc_mean_X"
[4] "mean_tBodyAcc_mean_Y"           "mean_tBodyAcc_mean_Z"           "mean_tBodyAcc_std_X"
[7] "mean_tBodyAcc_std_Y"            "mean_tBodyAcc_std_Z"            "mean_tGravityAcc_mean_X"
[10] "mean_tGravityAcc_mean_Y"        "mean_tGravityAcc_mean_Z"        "mean_tGravityAcc_std_X"
[13] "mean_tGravityAcc_std_Y"         "mean_tGravityAcc_std_Z"         "mean_tBodyAccJerk_mean_X"
[16] "mean_tBodyAccJerk_mean_Y"       "mean_tBodyAccJerk_mean_Z"       "mean_tBodyAccJerk_std_X"
[19] "mean_tBodyAccJerk_std_Y"        "mean_tBodyAccJerk_std_Z"        "mean_tBodyGyro_mean_X"
[22] "mean_tBodyGyro_mean_Y"          "mean_tBodyGyro_mean_Z"          "mean_tBodyGyro_std_X"
[25] "mean_tBodyGyro_std_Y"           "mean_tBodyGyro_std_Z"           "mean_tBodyGyroJerk_mean_X"
[28] "mean_tBodyGyroJerk_mean_Y"      "mean_tBodyGyroJerk_mean_Z"      "mean_tBodyGyroJerk_std_X"
[31] "mean_tBodyGyroJerk_std_Y"       "mean_tBodyGyroJerk_std_Z"       "mean_tBodyAccMag_mean"
[34] "mean_tBodyAccMag_std"           "mean_tGravityAccMag_mean"       "mean_tGravityAccMag_std"
[37] "mean_tBodyAccJerkMag_mean"      "mean_tBodyAccJerkMag_std"       "mean_tBodyGyroMag_mean"
[40] "mean_tBodyGyroMag_std"          "mean_tBodyGyroJerkMag_mean"     "mean_tBodyGyroJerkMag_std"
[43] "mean_fBodyAcc_mean_X"           "mean_fBodyAcc_mean_Y"           "mean_fBodyAcc_mean_Z"
[46] "mean_fBodyAcc_std_X"            "mean_fBodyAcc_std_Y"            "mean_fBodyAcc_std_Z"
[49] "mean_fBodyAccJerk_mean_X"       "mean_fBodyAccJerk_mean_Y"       "mean_fBodyAccJerk_mean_Z"
[52] "mean_fBodyAccJerk_std_X"        "mean_fBodyAccJerk_std_Y"        "mean_fBodyAccJerk_std_Z"
[55] "mean_fBodyGyro_mean_X"          "mean_fBodyGyro_mean_Y"          "mean_fBodyGyro_mean_Z"
[58] "mean_fBodyGyro_std_X"           "mean_fBodyGyro_std_Y"           "mean_fBodyGyro_std_Z"
[61] "mean_fBodyAccMag_mean"          "mean_fBodyAccMag_std"           "mean_fBodyBodyAccJerkMag_mean"
[64] "mean_fBodyBodyAccJerkMag_std"   "mean_fBodyBodyGyroMag_mean"     "mean_fBodyBodyGyroMag_std"
[67] "mean_fBodyBodyGyroJerkMag_mean" "mean_fBodyBodyGyroJerkMag_std"

The summary data produced by the script can be read into R from the current directory with the command `read.table("UCI_HAR_Dataset_summary.txt", header=TRUE)`
