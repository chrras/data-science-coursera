library(dplyr)

## Load data
setwd(paste0('/Users/Christoffer/data-science-coursera/',
             'exploratory-data-analysis/assignment-2/data-gitignore'))
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Aggregate data
NEI_Baltimore <- filter(NEI, fips == "24510", type == 'ON-ROAD')
yearlyEmission <- aggregate(NEI_Baltimore$Emission, by = list(NEI_Baltimore$year), FUN = sum)
colnames(yearlyEmission) <- c('Year', 'Emission')
yearlyEmission$Emission <- yearlyEmission$Emission / 1000

## Set png options
png('../plot5.png',
    width = 770,
    height = 480,
    units = "px")

## Plot PM2.5 motor vehicle emission development
par(mar = c(4,5,3,2))
plot(yearlyEmission,
     type = 'o',
     pch = 16,
     ylim = c(0, 0.4),
     ylab = expression(paste(PM[2.5], " motor vehicle emission [", 10^3, " tons]")),
     frame.plot = F,
     xaxt='n',
     main = expression(paste("Development of ", PM[2.5], " motor vehicle emission over time in Baltimore City")))
axis(side=1, at=c(1999, 2002, 2005, 2008))

dev.off()