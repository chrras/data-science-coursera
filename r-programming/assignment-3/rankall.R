rankall <- function(outcome, num = "best") {
        
        ## Read outcome data
        
        data <- read.csv("data/outcome-of-care-measures.csv",
                         colClasses = "character")
        
        ## Check that state and outcome are valid
        
        if (!is.element(state, data$State)) {
                stop('invalid state')
        }
        
        outcomeVec <- c('11' = 'heart attack',
                        '17' = 'heart failure',
                        '23' = 'pneumonia')
        
        if (!is.element(outcome, outcomeVec)) {
                stop('invalid outcome')
        }
        
        ## Find outcome collumn number
        
        idx <- match(outcome, outcomeVec)
        col <- as.integer(names(outcomeVec[idx]))
        
        #states <- unique(data$State)
        
        ## Subset and sort data
        
        suppressWarnings(data[, col] <- as.numeric(data[, col]))
        data <- data[!is.na(data[, col]), ]
        minRates <- tapply(data[, col], data$State, which.min)
        
        df <- data[minRates, c(2, 7)]
        colnames(df) <- c('hospital', 'state')
        
        for (state in states) {
                dataSub <- subset(data, State == state)
                suppressWarnings(dataSub[, col] <- as.numeric(dataSub[, col]))
                dataSub <- dataSub[!is.na(dataSub[, col]), ]
                dataSub <- dataSub[order(dataSub[, col], dataSub[, 2]), ]
        
                if (num == 'best') {
                        return(data[1, 2])
                } else if (num == 'worst') {
                        return(tail(data[, 2], 1))
                } else {
                        return(data[num, 2])
                }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        ## For each state, find the hospital of the given rank
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
}

?tapply
suppressWarnings(tapply(data[, col], data$State, which.min))
