library(dplyr)
library(ggplot2)

## Load data
setwd(paste0('/Users/Christoffer/data-science-coursera/',
             'exploratory-data-analysis/assignment-2/data-gitignore'))
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Aggregate data
NEI_Baltimore <- filter(NEI, fips == "24510")
yearlyEmission <- aggregate(NEI_Baltimore$Emission, by = list(NEI_Baltimore$year, NEI_Baltimore$type), FUN = sum)
colnames(yearlyEmission) <- c('Year', 'Type', 'Emission')
yearlyEmission$Emission <- yearlyEmission$Emission / 1000

yearlyEmission$Type <- factor(yearlyEmission$Type, levels = c("ON-ROAD", "NON-ROAD", "POINT", "NONPOINT"))

## Set png options
png('../plot3.png',
    width = 770,
    height = 480,
    units = "px")

## Plot PM2.5 emission development in Baltimore Ciry by type of scource
ggplot(data = yearlyEmission, aes(x = Year, y = Emission)) +
    geom_line() +
    geom_point() +
    scale_x_continuous(breaks = c(1999, 2002, 2005, 2008), labels = c('`99', '`02', '`05', '`08')) +
    ylab(expression(paste(PM[2.5], " emission [", 10^3, " tons]"))) +
    facet_grid(. ~ Type) +
    labs(title = "Development of PM2.5 emission over time in Baltimore City\n by type of source\n") +
    theme_bw(base_size = 14)

dev.off()