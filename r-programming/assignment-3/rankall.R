rankall <- function(outcome, num = "best") {
        
        ## Read outcome data
        
        data <- read.csv("data/outcome-of-care-measures.csv",
                         colClasses = "character")
        
        ## Check that state and outcome are valid
        
        outcomeVec <- c('11' = 'heart attack',
                        '17' = 'heart failure',
                        '23' = 'pneumonia')
        
        if (!is.element(outcome, outcomeVec)) {
                stop('invalid outcome')
        }
        
        ## Find outcome collumn number
        
        idx <- match(outcome, outcomeVec)
        col <- as.integer(names(outcomeVec[idx]))

        ## Subset and sort data
        
        suppressWarnings(data[, col] <- as.numeric(data[, col]))
        data <- data[!is.na(data[, col]), ]
        
        ## Sort
        
        if (num == 'worst') {
                data <- data[order(data[, 7], -data[, col]), ]
        } else {
                data <- data[order(data[, 7], data[, col]), ]
        }
        
        ## Find states and hospitals
        
        states <- unique(data$State)
        stateIdx <- match(states, data$State)
        
        if (!is.na(as.numeric(num))) {
                maxIdx <- c(stateIdx[-1], nrow(data)) - 1
                stateIdx <- stateIdx + (num-1)
                insideBounds <- stateIdx <= maxIdx
                stateIdx <- ifelse(insideBounds == TRUE, stateIdx, NA)
        }
        
        hospital <- data[stateIdx, 2]
        
        df <- data.frame(hospital, states)
}