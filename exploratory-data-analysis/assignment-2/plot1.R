## Load data
setwd(paste0('/Users/Christoffer/data-science-coursera/',
             'exploratory-data-analysis/assignment-2/data-gitignore'))
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Aggregate data
yearlyEmission <- aggregate(NEI$Emission, by = list(NEI$year), FUN = sum)
colnames(yearlyEmission) <- c('Year', 'Emission')
yearlyEmission$Emission <- yearlyEmission$Emission / 1000000

## Set png options
png('../plot1.png',
    width = 770,
    height = 480,
    units = "px")

## Plot PM2.5 emission development
par(mar = c(4,5,3,2))
plot(yearlyEmission,
     type = 'o',
     pch = 16,
     ylim = c(0, 8),
     ylab = expression(paste(PM[2.5], " emission [", 10^6, " tons]")),
     frame.plot = F,
     xaxt='n',
     main = expression(paste("Development of ", PM[2.5], " emission over time in the US")))
axis(side=1, at=c(1999, 2002, 2005, 2008))

dev.off()