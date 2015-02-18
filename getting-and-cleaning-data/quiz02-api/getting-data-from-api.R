library(httr)
library(httpuv)
library(jsonlite)

# Question 1 -----

myapp <- oauth_app("github",key="7d66716abcdc188f4b10",secret = "b9d1c273c5d309fa9affd9b6665b3974672ae7ff")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)

req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
# stop_for_status(req)
raw_result <- content(req)
# str(raw_result)
# class(raw_result)

jsoned <- toJSON(raw_result, pretty = T)
data <- fromJSON(jsoned)
names(data)

as.data.frame(data)

sub <- data$name=="datasharing"
data$created_at[sub]

# class(jsoned)
# names("raw_result")

# Question 2 -----

library(sqldf)

setwd('/Users/Christoffer/data-science-coursera/getting-and-cleaning-data/quiz02-api/data-gitignore')
acs <- read.csv('acs.csv')

head(sqldf("select pwgtp1 from acs where AGEP < 50"))

# Question 3 -----

unique(acs$AGEP)
sqldf("select distinct AGEP from acs")

# Questing 4 -----

con <- url('http://biostat.jhsph.edu/~jleek/contact.html')
html <- readLines(con)
close(con)

lines <- c(10, 20, 30, 100)
nchar(html[lines])

# Question 5 -----

width <- c(-1, 9, rep(c(-5, 4, -1, 3), 4))
data <- read.fwf('getdata-wksst8110.for', width = width, skip = 4)

sum(data[, 4])