  library(shiny)
  library(quantmod)
  library(PerformanceAnalytics)
  library(htmltab)
  library(DataCache)

  
  get_timeseries = function(stock_id) {
    
    AdjustedPrice = 6
    .stockdata = getSymbols(stock_id, warnings = FALSE, auto.assign = FALSE)
    stockdata = na.fill(.stockdata, fill = "extend")[, AdjustedPrice, drop=FALSE]
    
    return (stockdata)
  }
  
  datafeed_timeseries = function(stock_id) {
    
    
    timeseries = get_timeseries(stock_id)
    out = list(timeseries)
    names(out) = paste0('stockdata.', stock_id)
    
    return(out)
    
  }


  # # do timing tests
  #   varName1 = 'BAS.DE'
  # 
  # # delete the cache (just in case there are any leftovers) 
  #   junk <- dir(path="~/cache/", pattern=varName1, full.names = TRUE) # ?dir
  #   file.remove(junk) # ?file.remove
  #   
  # # first time
  #   start_time <- Sys.time()
  #   cache.stockdata = data.cache(function() datafeed_timeseries(varName1) , cache.name = varName1, frequency = daily, wait = FALSE)
  #   end_time <- Sys.time()
  # 
  #   timeTaken1 = end_time - start_time
  #   # Time difference of 0.3825941 secs
  # 
  # # second time
  #   start_time <- Sys.time()
  #   cache.stockdata = data.cache(function() datafeed_timeseries(varName1) , cache.name = varName1, frequency = daily, wait = FALSE)
  #   end_time <- Sys.time()
  #   
  #   timeTaken2 = end_time - start_time
  #   # Time difference of 0.003516197 secs
  # 
  # # this is the actual data
  #   tail(stockdata.BAS.DE)
  #   # BAS.DE.Adjusted
  #   # 2017-12-14           93.75
  #   # 2017-12-15           93.67
  #   # 2017-12-18           95.46
  #   # 2017-12-19           94.28
  #   # 2017-12-20           93.13
  #   # 2017-12-21           93.69
  # 
  # # delete the cache 
  #   junk <- dir(path="~/cache/", pattern=varName1, full.names = TRUE) # ?dir
  #   file.remove(junk) # ?file.remove
  # 
  # # third time
  #   start_time <- Sys.time()
  #   cache.stockdata = data.cache(function() datafeed_timeseries(varName1) , cache.name = varName1, frequency = daily, wait = FALSE)
  #   end_time <- Sys.time()
  #   
  #   timeTaken3 = end_time - start_time
  #   # Time difference of 0.4717042 secs
  # 
  # # fourth time
  #   start_time <- Sys.time()
  #   cache.stockdata = data.cache(function() datafeed_timeseries(varName1) , cache.name = varName1, frequency = daily, wait = FALSE)
  #   end_time <- Sys.time()
  #   
  #   timeTaken4 = end_time - start_time
  #   # Time difference of 0.003220558 secs
  # 
  #   # so retrieving the cache is significantly faster ...
  #   # we assert that it is more the 50 times faster
  #   assertthat::assert_that(timeTaken1>timeTaken2 * 50)
  #   assertthat::assert_that(timeTaken3>timeTaken4 * 50)
  #   
  #   # # in fact in this set up it is around 100 
  #   # as.numeric(timeTaken1)/as.numeric(timeTaken2)
  #   # # [1] 146.3878
  #   # as.numeric(timeTaken3)/as.numeric(timeTaken4)
  #   # # [1] 94.27676
  
  