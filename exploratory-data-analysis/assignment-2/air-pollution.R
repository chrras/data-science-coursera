library(dplyr)
library(ggplot2)

## Load data
setwd(paste0('/Users/Christoffer/data-science-coursera/',
             'exploratory-data-analysis/assignment-2/data-gitignore'))
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Task 1 ----

## Aggregate data
yearlyEmission <- aggregate(NEI$Emission, by = list(NEI$year), FUN = sum)
colnames(yearlyEmission) <- c('Year', 'Emission')
yearlyEmission$Emission <- yearlyEmission$Emission / 1000000

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

## Task 2 ----

## Aggregate data

NEI_Baltimore <- filter(NEI, fips == "24510")
yearlyEmission <- aggregate(NEI_Baltimore$Emission, by = list(NEI_Baltimore$year), FUN = sum)
colnames(yearlyEmission) <- c('Year', 'Emission')
yearlyEmission$Emission <- yearlyEmission$Emission / 1000

## Plot PM2.5 emission development in Baltimore Ciry
par(mar = c(4,5,3,2))
plot(yearlyEmission,
     type = 'o',
     pch = 16,
     ylim = c(0, 4),
     ylab = expression(paste(PM[2.5], " emission [", 10^3, " tons]")),
     frame.plot = F,
     xaxt='n',
     main = expression(paste("Development of ", PM[2.5], " emission over time in Baltimore City")))
axis(side=1, at=c(1999, 2002, 2005, 2008))

## Task 3 ----

## Aggregate data

NEI_Baltimore <- filter(NEI, fips == "24510")
yearlyEmission <- aggregate(NEI_Baltimore$Emission, by = list(NEI_Baltimore$year, NEI_Baltimore$type), FUN = sum)
colnames(yearlyEmission) <- c('Year', 'Type', 'Emission')
yearlyEmission$Emission <- yearlyEmission$Emission / 1000

yearlyEmission$Type <- factor(yearlyEmission$Type, levels = c("ON-ROAD", "NON-ROAD", "POINT", "NONPOINT"))


## Plot PM2.5 emission development in Baltimore Ciry
ggplot(data = yearlyEmission, aes(x = Year, y = Emission)) +
    geom_line() +
    geom_point() +
    scale_x_continuous(breaks = c(1999, 2002, 2005, 2008), labels = c('`99', '`02', '`05', '`08')) +
    ylab(expression(paste(PM[2.5], " emission [", 10^3, " tons]"))) +
    facet_grid(. ~ Type) +
    labs(title = "Development of PM2.5 emission over time in Baltimore City\n by type of source\n") +
    theme_bw(base_size = 14)

## Task 4 ----

## Filter data
CoalComb <- filter(SCC, grepl("[Cc]omb",Short.Name) & grepl("[Cc]oal", Short.Name))
CoalCombCombined <- merge(CoalComb, NEI, by.x = "SCC", by.y = "SCC")

## Aggregate data
yearlyCoalEmission <- aggregate(CoalCombCombined$Emissions, by = list(CoalCombCombined$year), FUN = sum)
colnames(yearlyCoalEmission) <- c('Year', 'Emission')
yearlyCoalEmission$Emission <- yearlyCoalEmission$Emission / 1000000

## Plot PM2.5 emission development
par(mar = c(4,5,3,2))
plot(yearlyCoalEmission,
     type = 'o',
     pch = 16,
     ylim = c(0, 0.6),
     ylab = expression(paste(PM[2.5], "coal emission [", 10^6, " tons]")),
     frame.plot = F,
     xaxt='n',
     main = expression(paste("Development of ", PM[2.5], " coal emission over time in the US")))
axis(side=1, at=c(1999, 2002, 2005, 2008))

## Task 5 ----

## Aggregate data

NEI_Baltimore <- filter(NEI, fips == "24510", type == 'ON-ROAD')
yearlyEmission <- aggregate(NEI_Baltimore$Emission, by = list(NEI_Baltimore$year), FUN = sum)
colnames(yearlyEmission) <- c('Year', 'Emission')
yearlyEmission$Emission <- yearlyEmission$Emission / 1000

## Plot PM2.5 emission development in Baltimore Ciry
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

## Task 6 ----

## Aggregate data

NEI_Baltimore_LA <- filter(NEI, fips %in% c("24510", "06037"), type == 'ON-ROAD')
yearlyEmission <- aggregate(NEI_Baltimore_LA$Emission, by = list(NEI_Baltimore_LA$year, NEI_Baltimore_LA$fips), FUN = sum)
colnames(yearlyEmission) <- c('Year', 'Fips', 'Emission')
yearlyEmission$Emission <- yearlyEmission$Emission / 1000
yearlyEmission$EmissionDiff <- c(yearlyEmission$Emission[1:4] - yearlyEmission$Emission[1],
                                 yearlyEmission$Emission[5:8] - yearlyEmission$Emission[5])

yearlyEmission$Fips <- factor(yearlyEmission$Fips)
levels(yearlyEmission$Fips) <- c('Los Angeles County', 'Baltimore City')

## Plot PM2.5 emission development in Baltimore Ciry
ggplot(data = yearlyEmission, aes(x = Year, y = Emission)) +
    geom_line() +
    geom_point() +
    scale_x_continuous(breaks = c(1999, 2002, 2005, 2008), labels = c('`99', '`02', '`05', '`08')) +
    ylab(expression(paste(PM[2.5], " emission [", 10^3, " tons]"))) +
    facet_grid(. ~ Fips) +
    labs(title = "Development of PM2.5 motor vehicle emission over time\n") +
    theme_bw(base_size = 14)

## Plot PM2.5 emission development in Baltimore Ciry
ggplot(data = yearlyEmission, aes(x = Year, y = EmissionDiff)) +
    geom_line() +
    geom_point() +
    scale_x_continuous(breaks = c(1999, 2002, 2005, 2008), labels = c('`99', '`02', '`05', '`08')) +
    ylab(expression(paste("Change in ", PM[2.5], " emission [", 10^3, " tons]"))) +
    facet_grid(. ~ Fips) +
    labs(title = "Development of PM2.5 motor vehicle emission over time\n") +
    theme_bw(base_size = 14)
