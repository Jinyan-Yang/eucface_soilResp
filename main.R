source('r/load.R')

source('r/get_swc.R')

# get swc and T for given dates
swc.df <- get.swv.t.func('2019-1-1',2019-1-2)

# read in the csv
resp.ls <- list()
for(i in 1:6){
  
  fn <- sprintf('data/SR-Ring%s-example.csv',i)
  df.tmp <- read.csv(fn,stringsAsFactors = FALSE)
  # change date formate
  df.tmp$DateTime <- strptime(df.tmp$Date_IV,'%d/%m/%Y %H:%M')
  df.tmp$Date <- as.Date(df.tmp$DateTime)
  df.tmp$Ring = paste0("R",i)
  resp.ls[[i]] <- df.tmp
}

resp.df <- do.call(rbind,resp.ls)

# merge the data frames by date and ring 
swc.resp.df <- merge(resp.df,swc.df,by=c('Date','Ring',all=T))


# ####na replacing
library(zoo)
swc.resp.df$CO2_IV <- na.fill(swc.resp.df$CO2_IV,'extend')