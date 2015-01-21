complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases

        data <- data.frame(integer(0), integer(0))
        
        for (i in id) {
                path <- paste(directory, "/", sprintf("%03d.csv", i), sep = "")
                nobs <- nrow(na.omit(read.csv(path)))
                data <- rbind(data, c(i, nobs))
        }
        
        colnames(data) <- c("id", "nobs")
        
        return(data)
}
