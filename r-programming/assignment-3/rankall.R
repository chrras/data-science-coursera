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
        
        ## Sort
        
        if (num == 'worst') {
                data <- data[order(data[, 7], -data[, col], data[, 2]), ]
                #newdata <- mtcars[order(mpg, -cyl),]
                #arrange(data, data[, 7], desc(data[, col]), data[, 2])
        } else {
                data <- data[order(data[, 7], data[, col], data[, 2]), ]
        }
        
        states <- unique(data$State)
#         suppressWarnings(data[, col] <- as.numeric(data[, col]))
        data <- data[!is.na(data[, col]), ]
        
        
        ## Find states and hospitals
        
#         states <- unique(data$State)
#         stateIdx <- match(states, data$State)

        df <- NULL
        
        if (num == 'best' | num == 'worst') {
                num <- 1
        }

        for (state in states) {
                
                sub <- subset(data, State == state)
#                 print(sub[, 2])
                hospital <- sub[num, 2]
                df <- rbind(df, c(hospital, state))
        }
        
#         View(data)
#         print(names(data))
#         print(data[, col]) 
#         print(subset(data, State == 'WY')[, c(2, col)])
        
        df <- as.data.frame(df)
        colnames(df) <- c('hospital', 'state')        

#         if (suppressWarnings(!is.na(as.numeric(num)))) {
#                 maxIdx <- c(stateIdx[-1], nrow(data)) - 1
#                 stateIdx <- stateIdx + (num-1)
#                 insideBounds <- stateIdx <= maxIdx
#                 stateIdx <- ifelse(insideBounds == TRUE, stateIdx, NA)
#         }
#         
#         hospital <- data[stateIdx, 2]
#         
#         df <- data.frame(hospital, states)
#         colnames(df) <- c('hospital', 'state')
#         
        return(df)
}

#library(plyr)
