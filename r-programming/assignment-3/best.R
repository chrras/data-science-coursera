best <- function(state, outcome) {
        data <- read.csv("outcome-of-care-measures.csv",
                         colClasses = "character")
        
        #stateVec <- subset(data, State == 'ALL')
        stateVec <- subset(data, State == state)
        if (nrow(stateVec) == 0) {
                return(message('Undefined state!'))
                
        }
        ## Check that state and outcome are valid
        ## Return hospital name in that state with lowest 30-day death
        ## rate
}

best('AL')
