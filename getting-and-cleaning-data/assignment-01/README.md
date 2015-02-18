## README

### Samsung accelerometer data cleaning function: _run-analysis.R_

The function, run-analysis.R, merge the Samsung accelerometer training and test data, and clean it. The function returns a data frame consisting of the average mean and std values for each subject and activity, which can be saved for later use.

------

The function requires _reshape2_ and _dplyr_ to be installed on the computer. Before running the function it is important to make sure that your working directory is the same as where the Samsung data is stored. The data can be downloaded from the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The function loads the following files and merge or use them in order to clean the data:
- features.txt
- activity_lables.txt
- X_train.txt
- y_train.txt
- subject_train.txt
- X_test.txt
- y_test.txt
- subject_test.txt

Collumns NOT containing mean or standard deviations are excluded from the merged data.

The mean values of the means and standard deviations from the Samsung accelerometer is lastly returned for each activity and subject. See code-book.md for detailes on the different activities and subjects.

