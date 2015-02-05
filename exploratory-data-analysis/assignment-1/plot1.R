## Load required functions ----

setwd(paste('/Users/Christoffer/data-science-coursera/',
            'exploratory-data-analysis/assignment-1', sep = ""))

source('load_data.R')

## Load data ----

data <- load_data()  # See the load_data.R file for details

## Create histogram ----

png('plot1.png')

hist(data$Global_active_power,
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)',
     col = 'red')

dev.off()