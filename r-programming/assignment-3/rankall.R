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

        ## Convert outcome collumn to numeric and removeing NAs
        
        states <- unique(data$State)
        suppressWarnings(data[, col] <- as.numeric(data[, col]))
        data <- data[!is.na(data[, col]), ]
        
        ## Sort
        
        if (num == 'worst') {
                data <- data[order(data[, 7], -data[, col], data[, 2]), ]
        } else {
                data <- data[order(data[, 7], data[, col], data[, 2]), ]
        }
        
        ## Create data frame
        
        df <- NULL
        
        if (num == 'best' | num == 'worst') {
                num <- 1
        }

        for (state in states) {
                sub <- subset(data, State == state)
                hospital <- sub[num, 2]
                df <- rbind(df, c(hospital, state))
        }
        
        df <- as.data.frame(df)
        colnames(df) <- c('hospital', 'state')        

        return(df)
}