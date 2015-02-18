setwd("/Users/Christoffer/data-science-coursera/getting-and-cleaning-data/quiz03-manipulate/data-gitignore")

# Question 1 ----

## Download data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, "agriculture.csv", method = "curl")

## Load data
data <- read.csv("agriculture.csv")

## find right properties
agricultureLogical <- (data$ACR == 3 & data$AGS == 6)
which(agricultureLogical)  # Returns the TRUE indices of agricultureLogical


# Question 2 ----

library(jpeg)

## Download data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url, "picture.jpg", method = "curl")

## Load data
pic <- readJPEG("picture.jpg", native = TRUE)

## Get percentiles
quantile(pic, probs = c(0.3, 0.8))


# Question 3 ----

library(dplyr)

## Download data
url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url1, "gdp.csv", method = "curl")

url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url2, "edu.csv", method = "curl")

## Determine class of each collumn
init <- read.csv('gdp.csv', header = FALSE, skip = 5, nrow = 25)
classes <- sapply(init, class)

classes <- c("factor", "integer", "logical", "factor", "numeric", "factor", "logical", "logical", "logical", "logical")

## Load data
gdp <- read.csv("gdp.csv", skip = 5, header = FALSE)
edu <- read.csv("edu.csv")

## Clean gdp data
gdpClean <- gdp %>%
    select(-(V7:V10), -V3) %>%
    rename(id = V1, rank = V2, country = V4, usd = V5, note = V6) %>%
    filter(rank != "", id != "")

gdpClean$rank <- as.integer(as.character(gdpClean$rank))

## Merge data
mergeData <- merge(gdpClean, edu, by.x = "id", by.y = "CountryCode")

## Arrange data
arrangeData <- arrange(mergeData, desc(rank))

## Get cuntry number 13 from top
arrangeData$country[13]


# Question 4 ----

# arrangeData$usd <- as.numeric(gsub(",", "", arrangeData$usd))

mean(filter(arrangeData, Income.Group == "High income: OECD")$rank)
mean(filter(arrangeData, Income.Group == "High income: nonOECD")$rank)

# Question 5 ----

## Cut
arrangeData$rankGroup <- cut(arrangeData$rank, breaks = quantile(arrangeData$rank, probs = seq(0, 1, length = 6)), include.lowest = TRUE)
arrangeData$rankGroup

quantile(arrangeData$rank, probs = seq(0, 1, length = 6))

table(arrangeData$Income.Group, arrangeData$rankGroup)
