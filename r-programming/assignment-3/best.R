best <- function(state, outcome) {
        data <- read.csv("outcome-of-care-measures.csv",
                         colClasses = "character")
        
        ## Check that state and outcome are valid
        
        if (!is.element(state, data$State)) {
                stop('Undefined state name')
        }
        
        outcomeVec <- c('11' = 'heart attack',
                        '17' = 'heart failure',
                        '23' = 'pneumonia')
        
        if (!is.element(outcome, outcomeVec)) {
                stop('Undefined outcome')
        }
        
        idx <- match('heart attack', outcomeVec)
        col <- as.integer(names(outcomeVec[idx]))
        
        stateVec <- subset(data, State == state)
        
        ## Return hospital name in that state with lowest 30-day death rate
        
        
}

best('ALL')
exists('AL', data)
is.element('AL', data$State)
