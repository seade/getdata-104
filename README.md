# getdata-104

## Coursera Getting and Cleaning Data (getdata-104) Course Project.

Clean up and summarise the _Human Activity Recognition Using Smartphones Dataset
(Version 1.0)_ data set obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip as documented at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This data set consists of the following files

* READEME.md
 * The document you are reading
* run_analysys.R
 * An R script that downloads the raw data zip file if is it not present in the current working directory, unzips it and then tidies it up by combining the _test_ and _train_ data vertically, and the _subject_ & _activity_ (y) data to the main data (x).  The tidy data is written to a file named "UCI_HAR_Dataset_cleaned.txt".  The script then produces a summary of the tidy data that provides the _average_ of each variable for each _activity_ and _subject_.  The _summary_ file is named "UCI_HAR_Dataset_summary.txt".
* CodeBook.md
 * This provides details of the data that is included in the _summary_ file and the steps that were taken to produce it.

To execute the script from the current working directory you should enter `source("run_analysys.R")`.  If the source data file "UCI_HAR_Dataset.zip" is not present in the current working directory it will be downloaded.

The summary data produced by the script can be read into R from the current directory with the command `read.table("UCI_HAR_Dataset_summary.txt", header=TRUE)`

**Important:** This script always works with the zip file.  If the unzipped directory is present it will be deleted at the commencement of the script and replaced with the contents of the zip file.
