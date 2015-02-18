run_analysis <- function() {

    require(reshape2)
    require(dplyr)
    
    ## Load header and activity labels
    header <- read.table('features.txt', colClasses = 'character')
    labels <- read.table('activity_labels.txt', colClasses = 'character')
    
    ## Load data for train and test data sets (measurements, activity, subject)
    for(i in c('train', 'test')) {
        measurement <- read.table(paste0(i, '/X_', i, '.txt'), colC = 'numeric')
        activity <- read.table(paste0(i, '/y_', i,'.txt'), colC = 'character')
        subject <- read.table(paste0(i, '/subject_', i,'.txt'), colC = 'integer')
        
        ## Combine and name data (1st loop: training data, 2nd loop: test data).
        ## A 3rd collumn is create to indicate if the data is from train or test
        assign(i, cbind(subject, activity, rep(i, nrow(subject)), measurement))
    }
    
    ## Merges the training and the test sets to create one data set
    data <- rbind(train, test)
    
    ## Add descriptive header
    colnames(data) <- c('subject', 'activity', 'case', header[, 2])

    ## Extracts collumn names ending on 'mean()' or 'std()'
    data <- cbind(data[, 1:3],
                  data[, grepl('mean()', colnames(data), fixed = TRUE) |
                         grepl('std()', colnames(data), fixed = TRUE)])
    
    ## Create descriptive activity names
    for (i in 1:nrow(labels)) {
        data$activity <- gsub(as.character(i), labels[i, 2], data$activity)
    }
    data$activity <- tolower(data$activity)  # Make lower case
    
    ## Creates a independent data set with the average of each variable for each
    ## activity and each subject.
    data_melt <- melt(data, id.vars = c("subject", "activity", "case"))
    data_cast <- dcast(data_melt, subject + activity ~ variable, mean)
    data_cast <- arrange(data_cast, activity, subject)
    
    return(data_cast)
}