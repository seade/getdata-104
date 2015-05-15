# getdata-104

## Coursera Getting and Cleaning Data (getdata-104) Course Project.

The main components of this project are

* run_analysys.R
 * This script that downloads raw data zip file if is it not present in the current working directory, unzips it and then tidies it up by combining the _test_ and _train_ data sets vertically, and the _subject_ & _activity_ (y) to the main data (x).  The tidy data is written to a file named "UCI_HAR_Dataset_cleaned.txt" and then produces summary of the tidy data that provides the _average_ of each variable for each _activity_ and _subject_.  The _summary_ file is named "UCI_HAR_Dataset_summary.txt".
* CodeBook.md
 * This provides details of the data that is included in the _summary_ file and the steps that were taken to produce it.

To execute the script from the current working directory you should enter `source("run_analysys.R")`.  If the source data file "UCI_HAR_Dataset.zip" is not present it will be downloaded.

**Important:** This script always works with the zip file.  If the unzipped directory is present it will be deleted at the commencement of the script and replaced with the contents of the zip file.
