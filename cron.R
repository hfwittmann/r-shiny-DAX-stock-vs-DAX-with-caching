
  library(quantmod)
  library(PerformanceAnalytics)
  library(htmltab)
  library(DataCache)

  # closeAllConnections()
  setwd('/srv/shiny-server/r-shiny-DAX-stock-vs-DAX-with-caching/')
  
  source('./subs/getDAX_components.R')
  source('./subs/getTimeseries.R')
  
  
  # saved under DAX.components.Symbol
  cache.components = data.cache(function() datafeed_components() , cache.dir = "./cache", cache.name = 'components', frequency = daily, wait = FALSE)
  
  DAX.components.Symbol.plus =  c("^GDAXI" = "^GDAXI" , DAX.components.Symbol)
  
  for (varName2 in DAX.components.Symbol.plus) {
   
    cache.stockdata = data.cache(function() datafeed_timeseries(varName2) , cache.dir = "./cache", cache.name = varName2, frequency = daily, wait = FALSE) 
  }
