  silent <- lapply(list.files('./subs', pattern = '.(R|r)$', full.names = TRUE), source) # source all R-files in subs folder
  
  # saved under DAX.components.Symbol
  cache.components = data.cache(function() datafeed_components() , cache.name = 'components', frequency = daily, wait = FALSE)
  
  DAX.components.Symbol.plus =  c("^GDAXI" = "^GDAXI" , DAX.components.Symbol)
  
  for (varName2 in DAX.components.Symbol.plus) {
   
    cache.stockdata = data.cache(function() datafeed_timeseries(varName2) , cache.name = varName2, frequency = daily, wait = FALSE) 
  }
