run_analysis <- function() {

#     require(dplyr)
    
    setwd('data-gitignore')
    
    ## Load header and activity labels
    header <- read.table('features.txt', colClasses = 'character')
    labels <- read.table('activity_labels.txt', colClasses = 'character')
    
    ## Load data for training and test data sets
    for(i in c('train', 'test')) {
        ## Load measurements
        data <- read.table(paste0(i, '/X_', i, '.txt'), colC = 'numeric')
        ## Load activity collumn
        activity <- read.table(paste0(i, '/y_', i,'.txt'), colC = 'character')
        ## Load subject collumn
        subject <- read.table(paste0(i, '/subject_', i,'.txt'), colC = 'factor')
    
        ## Combine data (first loop: training data, second loop: test data)
        assign(i, cbind(subject, activity, rep(i, nrow(subject)), data))
    }
    
    ## Merges the training and the test sets to create one data set
    data <- rbind(train, test)
    colnames(data) <- c('subject', 'activity', 'case', header[, 2])

    ## Extracts collumn names ending on 'mean()' or 'std()'
    data <- data[, grepl('mean()', colnames(data[-(1:3)]), fixed = TRUE) |
                     grepl('std()', colnames(data[-(1:3)]), fixed = TRUE)]
    
    ## Create descriptive activity names
    for (i in 1:nrow(labels)) {
        data$activity <- gsub(as.character(i), labels[i, 2], data$activity)
    }
    ## convert text to lower case
    data$activity <- tolower(data$activity)

    ## Appropriately labels the data set with descriptive variable names
    
    
    
    ## 5.   From the data set in step 4, creates a second, independent tidy
    ##      data set with the average of each variable for each activity and each subject.

}

setwd('data-gitignore')
folder <- 'test'
test_data <- read.table('test/X_test.txt'), colClasses = 'numeric')
header <- read.table('X_test.txt', header = F, colClasses = 'numeric')
