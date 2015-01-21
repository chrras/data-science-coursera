corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
        
        # Vector with id's of complete observations above the threshold
        id <- subset(complete("specdata"), nobs > threshold)$id
        
        #sulfate <- numeric()
        #nitrate <- numeric()
        
        corvec <- numeric()
        
        for (i in id) {
                path <- paste(directory, "/", sprintf("%03d.csv", i), sep = "")
                data <- na.omit(read.csv(path))
                corvec <- append(corvec, cor(data$sulfate, data$nitrate))
        }
        
        return(corvec)
}