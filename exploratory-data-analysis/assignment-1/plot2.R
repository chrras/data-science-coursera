## Load required functions -----------------------------------------------------

setwd(paste('/Users/Christoffer/data-science-coursera/',
            'exploratory-data-analysis/assignment-1', sep = ""))

source('load_data.R')


## Load data -------------------------------------------------------------------

data <- load_data()  # See the load_data.R file for details


## Create directory 'plots' if it doesn't exists -------------------------------

if(!file.exists('plots')) {
    dir.create('plots')
}


## Plotting --------------------------------------------------------------------

## Set language to US english
Sys.setlocale("LC_TIME", "en_US")

## Set png options
png('plots/plot2.png',
    width = 480,
    height = 480,
    units = "px")

## Create plot
plot(as.POSIXct(paste(data$Date, data$Time)), data$Global_active_power,
     type = 'l',
     xlab = '',
     ylab = 'Global Active Power (kilowatts)')

dev.off()