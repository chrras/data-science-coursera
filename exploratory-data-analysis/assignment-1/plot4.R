## Define load_data functions --------------------------------------------------

load_data <- function(path = paste0('/Users/Christoffer/data-science-coursera/',
                                    'exploratory-data-analysis/assignment-1')) {
    
    setwd(path)
    
    ## Create folder for data
    if (!file.exists('data-gitignore')) {
        dir.create('data-gitignore')
        setwd('./data-gitignore')
    }
    
    setwd('./data-gitignore')
    
    if (!file.exists('household_power_consumption_subset.txt')) {
        
        ## Downloading and unzipping data
        if (!file.exists('household_power_consumption.txt')) {
            download.file(paste0('https://d396qusza40orc.cloudfront.net/',
                                 'exdata%2Fdata%2Fhousehold_power_',
                                 'consumption.zip'),
                          destfile = 'household_power_consumption.zip',
                          method = 'curl')
            
            unzip('household_power_consumption.zip')
        }
        
        ## Create header in new subset file via Terminal (Mac)
        system(paste0("head -n 1 household_power_consumption.txt",
                      "> household_power_consumption_subset.txt"))
        
        ## Append lines with the right date via Terminal (Mac)
        system(paste0("grep ^[1-2]/2/2007 household_power_",
                      "consumption.txt >> household_power_",
                      "consumption_subset.txt"))
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


## Load data -------------------------------------------------------------------

data <- load_data()


## Create directory 'plots' if it doesn't exists -------------------------------

if(!file.exists('plots')) {
    dir.create('plots')
}


## Plotting --------------------------------------------------------------------

## Set language to US english
Sys.setlocale("LC_TIME", "en_US")

## Set png options
png('plots/plot4.png',
    width = 480,
    height = 480,
    units = "px")

## Create plot
par(mfcol = c(2, 2))

## Plot 1
plot(as.POSIXct(paste(data$Date, data$Time)), data$Global_active_power,
     type = 'l',
     xlab = '',
     ylab = 'Global Active Power')

## Plot 2
plot(as.POSIXct(paste(data$Date, data$Time)), data$Sub_metering_1, type = 'l',
     xlab = '',
     ylab = 'Energy sub metering')
lines(as.POSIXct(paste(data$Date, data$Time)), data$Sub_metering_2, type="l", col="red")
lines(as.POSIXct(paste(data$Date, data$Time)), data$Sub_metering_3, type="l", col="blue")
legend('topright',
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col = c('black', 'red', 'blue'),
       lwd = 1,
       box.lwd = 0,
       bg = NA)

## Plot 3
plot(as.POSIXct(paste(data$Date, data$Time)), data$Voltage,
     type = 'l',
     xlab = 'datetime',
     ylab = 'Voltage')

## Plot 4
plot(as.POSIXct(paste(data$Date, data$Time)), data$Global_reactive_power,
     type = 'l',
     xlab = 'datetime',
     ylab = 'Global_reactive_power')

dev.off()