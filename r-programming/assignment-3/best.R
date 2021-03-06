best <- function(state, outcome) {
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
        
        ## Subset and sort data
        
        data <- subset(data, State == state)
        data <- data[order(data$Hospital.Name), ]
        
        ## Find minimum rate
        
        suppressWarnings(minRate <- which.min(as.numeric(data[, col])))
        
        ## Return hospital name in that state with lowest 30-day death rate
        
        data[minRate, 2]
}
