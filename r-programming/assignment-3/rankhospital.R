rankhospital <- function(state, outcome, num = "best") {
        
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
        
        # idx <- match(outcome, outcomeVec)
        idx <- match(outcome, outcomeVec)
        col <- as.integer(names(outcomeVec[idx]))
        
        ## Subset and sort data
        
        data <- subset(data, State == state)    ## Subset
        data[, col] <- as.numeric(data[, col])  ## Convert outcome to numeric
        data <- data[!is.na(data[, col]), ]     ## Remove NAs
        data <- data[order(data[, col], data$Hospital.Name), ]  ## Sort data (lo -> hi)
        # data <- data[order(data[, col]), ]  ## Sort data (lo -> hi)
        
        if (num == 'best') {
                return(data[1, 2])
        } else if (num == 'worst') {
                return(tail(data[, 2], 1))
        } else {
                return(data[num, 2])
        }
}