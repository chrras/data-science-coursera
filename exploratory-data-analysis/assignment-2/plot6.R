library(dplyr)
library(ggplot2)

## Load data
setwd(paste0('/Users/Christoffer/data-science-coursera/',
             'exploratory-data-analysis/assignment-2/data-gitignore'))
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Aggregate data
NEI_Baltimore_LA <- filter(NEI, fips %in% c("24510", "06037"), type == 'ON-ROAD')
yearlyEmission <- aggregate(NEI_Baltimore_LA$Emission, by = list(NEI_Baltimore_LA$year, NEI_Baltimore_LA$fips), FUN = sum)
colnames(yearlyEmission) <- c('Year', 'Fips', 'Emission')
yearlyEmission$Emission <- yearlyEmission$Emission / 1000
yearlyEmission$EmissionDiff <- c(yearlyEmission$Emission[1:4] - yearlyEmission$Emission[1],
                                 yearlyEmission$Emission[5:8] - yearlyEmission$Emission[5])

yearlyEmission$Fips <- factor(yearlyEmission$Fips)
levels(yearlyEmission$Fips) <- c('Los Angeles County', 'Baltimore City')

## Set png options
png('../plot6.png',
    width = 770,
    height = 480,
    units = "px")

## Plot PM2.5 motor vehicle emission change in Baltimore Ciry and LA
ggplot(data = yearlyEmission, aes(x = Year, y = EmissionDiff)) +
    geom_line() +
    geom_point() +
    scale_x_continuous(breaks = c(1999, 2002, 2005, 2008), labels = c('`99', '`02', '`05', '`08')) +
    ylab(expression(paste("Change in ", PM[2.5], " emission [", 10^3, " tons]"))) +
    facet_grid(. ~ Fips) +
    labs(title = "Development of PM2.5 motor vehicle emission over time\n") +
    theme_bw(base_size = 14)

dev.off()