#### Setup Directory-Library-Load ####
library(ggplot2)
setwd("C:/Users/MAX/Documents/GitHub/P6 - Data Visualization/data/")
data <- read.csv("prosperLoanData.csv", stringsAsFactors = FALSE)

#### Clean ####

### Subset ###
prosper_clean <- subset(data, select=c(LoanOriginationDate, 
                                       EstimatedEffectiveYield, 
                                       EstimatedLoss, 
                                       EstimatedReturn, 
                                       ProsperRating..Alpha.))
colnames(prosper_clean) <- c("loan_date", "est_yield", "est_loss", "est_return", "rating")

prosper_clean <- subset(prosper_clean, rating != "") # dim(pr) [1] 84853     5

prosper_clean$loan_date <- gsub(" .*", "", prosper_clean$loan_date) # removes everything after fist blank - time sequence
prosper_clean$loan_date <- as.Date(prosper_clean$loan_date, "%Y-%m-%d") # converts to date - starts on 7-20-2009 now

#prosper_clean$rating <- ordered(prosper_clean$rating)
#prosper_clean$rating <- ordered(prosper_clean$rating, levels = c("AA", "A", "B", "C", "D", "E", "HR"))

#### Explore ####
qplot(data=prosper_clean, loan_date)
qplot(data=prosper_clean, rating)
qplot(data=prosper_clean, est_yield)
qplot(data=prosper_clean, est_return)
qplot(data=prosper_clean, est_loss)

# Add year
prosper_clean$year <- as.character(as.POSIXlt(prosper_clean$loan_date)$year + 1900)

## It looks like they changed something in 2011. Est Return was euqal to Estimated Yield in 2009 and 2010
ggplot(data=prosper_clean, aes(x=rating, y=est_return, group=1)) + 
  stat_summary(fun.y=mean, colour="black", geom="line") +
  stat_summary(aes(y=est_loss), fun.y=mean, colour="red", geom="line") +
  stat_summary(aes(y=est_yield), fun.y=mean, colour="blue", geom="line") +
  stat_summary(fun.y=mean, colour="black", geom="point") +
  stat_summary(aes(y=est_loss), fun.y=mean, colour="red", geom="point") +
  stat_summary(aes(y=est_yield), fun.y=mean, colour="blue", geom="point") +
  facet_grid(~year)

#### Clean More ####
prosper_clean <- subset(prosper_clean, year > 2010)
#prosper_clean$loan_date <- as.character(prosper_clean$loan_date)
prosper_clean_2014 <- subset(prosper_clean, year == 2014)
prosper_clean_2013 <- subset(prosper_clean, year == 2013)
prosper_clean_2012 <- subset(prosper_clean, year == 2012)
prosper_clean_2011 <- subset(prosper_clean, year == 2011)
#### Cast to long format ####

#### Write out data file ####
write.csv(prosper_clean, file = paste0(getwd(), "/prosper_clean.csv"), row.names=FALSE)
write.csv(prosper_clean_2014, file = paste0(getwd(), "/prosper_clean_2014.csv"), row.names=FALSE)
write.csv(prosper_clean_2013, file = paste0(getwd(), "/prosper_clean_2013.csv"), row.names=FALSE)
write.csv(prosper_clean_2012, file = paste0(getwd(), "/prosper_clean_2012.csv"), row.names=FALSE)
write.csv(prosper_clean_2011, file = paste0(getwd(), "/prosper_clean_2011.csv"), row.names=FALSE)
# library(caret)
# set.seed(3416)
# trainIndex <- createDataPartition(prosper_clean, p = .4)

prosper_small <- prosper_clean[ 1:20000,]

write.csv(prosper_small, file = paste0(getwd(), "/prosper_clean_small.csv"), row.names=FALSE)

