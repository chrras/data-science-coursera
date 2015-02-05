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


## Plotting  -------------------------------------------------------------------

## Set png options
png('plots/plot1.png',
    width = 480,
    height = 480,
    units = "px")

## Create plot
hist(data$Global_active_power,
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)',
     col = 'red')

dev.off()