load_data <- function(path = paste('/Users/Christoffer/data-science-coursera/',
                      'exploratory-data-analysis/assignment-1', sep = "")) {
        
    setwd(path)
    
    if (!file.exists('data-gitignore')) {
            dir.create('data-gitignore')
            setwd('./data-gitignore')
    }

    setwd('./data-gitignore')
    
    if (!file.exists('household_power_consumption_subset.txt')) {
        
        ## Downloading and unzipping data
        if (!file.exists('household_power_consumption.txt')) {
            download.file(paste('https://d396qusza40orc.cloudfront.net/',
                                'exdata%2Fdata%2Fhousehold_power_',
                                'consumption.zip', sep = ""),
                          destfile = 'household_power_consumption.zip',
                          method = 'curl')
        
            unzip('household_power_consumption.zip')
        }
        
        ## Create header in new subset file via Terminal (Mac)
        system(paste("head -n 1 household_power_consumption.txt",
                     "> household_power_consumption_subset.txt",
                     sep = ""))
        
        ## Append lines with the right date via Terminal (Mac)
        system(paste("grep ^[1-2]/2/2007 household_power_",
                     "consumption.txt >> household_power_",
                     "consumption_subset.txt", sep = ""))
    }
    
    ## Load and format data
    
    ## Determine class of each collumn
    init <- read.table('household_power_consumption_subset.txt', header = TRUE, 
                       sep = ";", nrow = 25)
    classes <- sapply(init, class)
    
    ## Load data
    powerComsumption <- read.table('household_power_consumption_subset.txt',
                                   header = TRUE, sep = ";", colClasses = classes, 
                                   na.string = "?")
    
    ## Format time and date
    powerComsumption$Date <- strptime(powerComsumption$Date, format = "%d/%m/%Y")
    powerComsumption$Time <- strptime(powerComsumption$Time, format = "%H:%M:%S")
    powerComsumption$Time <- strftime(powerComsumption$Time, "%H:%M:%S")
    
    setwd('..')
    return(powerComsumption)
}