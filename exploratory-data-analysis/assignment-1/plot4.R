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