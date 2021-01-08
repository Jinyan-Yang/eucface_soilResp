
get.swv.t.func <- function(start.date,end.date){
  swc.day.ls <- list()
  for ( i in 1:6){
    
    swc.df <- downloadTOA5(sprintf("FACE_R%s_B1_SoilVars",i),
                           startDate = '2019-01-01',
                           endDate = '2019-1-3')
    meanVWC <- function(dfr,col.nm = "VWC_",cut.off=NA){
      vwccols <- grep(col.nm,names(dfr))
      dfr <- dfr[,vwccols]
      if(!is.na(cut.off)){
        dfr[dfr > cut.off] <- NA
      }
      rowMeans(dfr, na.rm=TRUE)
    }
    
    swc.df$swc.tdr <- meanVWC(swc.df,,col.nm = "VWC_",cut.off=1) * 100
    swc.df$t.tdr <- meanVWC(swc.df,,col.nm = "TDRTemp_",cut.off=NA) 
    
    swc.df <- subset(swc.df,select = c("Date",
                                       "DateTime",
                                       "t.tdr",'swc.tdr'))
    
    # the theta probes are mislabled as tdr here 
    swc.day.ls[[i]] <- data.table(swc.df)[,list(Ring = paste0("R",i),
                                                t.tdr = mean(t.tdr, na.rm=TRUE),
                                                swc.tdr = mean(swc.tdr, na.rm=TRUE)),
                                          
                                          by = Date]
    
    
  }
  
  swc.day.df <- do.call(rbind,swc.day.ls)
  swc.day.df <- swc.day.df[order(swc.day.df$Date),]
  
  saveRDS(swc.day.df,'cache/swc.day.df.rds')
  
  return(swc.day.df)
}


