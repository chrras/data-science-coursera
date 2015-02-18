run_analysis <- function() {

    ## You should create one R script called run_analysis.R that does the
    ## following:
    
    require(dplyr)
    
    ## 1.   Merges the training and the test sets to create one data set.
    setwd('data-gitignore')
    header <- read.table('features.txt', colClasses = 'character')
    labels <- read.table('activity_labels.txt', colClasses = 'character')
    
    for(i in c('train', 'test')) {
        data <- read.table(paste0(i, '/X_', i, '.txt'), colC = 'numeric')
        activity <- read.table(paste0(i, '/y_', i,'.txt'), colC = 'character')
        subject <- read.table(paste0(i, '/subject_', i,'.txt'), colC = 'factor')
    
        assign(i, cbind(subject, activity, rep(i, nrow(subject)), data))
    }
    
    data <- rbind(train, test)
    colnames(data) <- c('subject', 'activity', 'case', header[, 2])

    ## 2.   Extracts only the measurements on the mean and standard
    ##      deviation for each measurement.
    
    data <- data[, grepl('mean()', colnames(data[-(1:3)]), fixed = TRUE) |
                     grepl('std()', colnames(data[-(1:3)]), fixed = TRUE)]
    
    ## Uses descriptive activity names to name the activities in the data set.
    
    labels[, 2] <- tolower(labels[, 2])
    
    for (i in 1:nrow(labels)) {
        data$activity <- gsub(as.character(i), labels[i, 2], data$activity)
    }
    
    chartr('123', 'ABC', c(1,2,3,4,5))
    ?sub
    ## 4.   Appropriately labels the data set with descriptive variable
    ##      names. 
    ## 5.   From the data set in step 4, creates a second, independent tidy
    ##      data set with the average of each variable for each activity and each subject.

}

setwd('data-gitignore')
folder <- 'test'
test_data <- read.table('test/X_test.txt'), colClasses = 'numeric')
header <- read.table('X_test.txt', header = F, colClasses = 'numeric')
