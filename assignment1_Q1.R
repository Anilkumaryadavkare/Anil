library(DBI)
library(RSQLite)

con <- dbConnect(RSQLite::SQLite(),'wooldridge2.db')
dbListTables(con)
wage1 <- data.table(dbReadTable(con,'wage1'))
dbReadTable(con,'wage1_labels')
dbDisconnect(con)
rm(con)
tabn <- 'wage1'
paste(tabn,'labels',sep = "_")

wpull <- function(wage1){
  con <- DBI::dbConnect(RSQLite::SQLite(),'wooldridge2.db')
  dt <- DBI::dbReadTable(con,wage1)
  dt <- data.table(dt)
  print(DBI::dbReadTable(con,paste(wage1,'labels',sep = '_')))
  DBI::dbDisconnect(con)
  rm(con)
  return(dt)
}
wage1 <- wpull('wage1')

#######{1}###########
mean(wage1$educ)
## The average eduaction level in the sample

min(wage1$educ)
## The lowest years of eductaion level in the sample

max(wage1$educ)
## The highest years of eductaion level in the sample

########{2}#############
mean(wage1$wage)
##The average of average hourly wage 
##The average hourly wage seems low

#########{3}#############
library(blscrapeR)
df <- bls_api("CUSR0000SA0")
head(df)
## to install and get the CPI values

library(blscrapeR)
da <- inflation_adjust(1976)
tail(da)
## to get values to CPI pertaining to year 1976

library(blscrapeR)
dc <- inflation_adjust(2010)
tail(dc)
## to get values to CPI pertaining to year 2010

################{4}###############

dc <- data.table(dc)
## converting to data table
head(dc)
mean(dc$avg_cpi)
## getting the average value in 2010

## The average value seems to pretty high when compared to pervious average hour average hourly wage 

##########{5}################
wage1$female
wage1[,.N,by=female]
s <- split(wage1$female,list(wage1$female))
s
## so, they are 252 females and 274 males












