  library(shiny)
  library(quantmod)
  library(PerformanceAnalytics)
  library(htmltab)

  get_components = function()
  
  {## get dax components names
    
    # to make the app faster we save the file 
    require(htmltab)
    tabledata.url <- "https://en.wikipedia.org/wiki/DAX"
    DAX.components = htmltab(doc = tabledata.url, which=3, rm_nodata_cols = F)
    # write.csv(x=DAX.components, file='./csv/DAX.components.csv')
    
    # # to make faster 
    # DAX.components = read.csv(file='./DAX.components.csv', header = TRUE, check.names = FALSE)
    
    DAX.components.Symbol = paste0( DAX.components[['Ticker symbol']], '.DE')
    names(DAX.components.Symbol) =  paste0( DAX.components[['Company']], ' (', DAX.components[['Prime Standard industry group']] ,')' )
      
    return (DAX.components.Symbol)
  } # {## get dax components names
  
  
  # DataCache preparation
  datafeed_components = function() {
    
    components = get_components()
    out = list(DAX.components.Symbol = components)
    
    return(out)
  }

# 
#   # delete the cache (just in case there are any leftovers)
#     junk <- dir(path="~/cache/", pattern='components', full.names = TRUE) # ?dir
#     file.remove(junk) # ?file.remove
# 
#   # first time
#     start_time <- Sys.time()
#     cache.components = data.cache(function() datafeed_components() , cache.name = 'components', frequency = daily, wait = FALSE)
#     end_time <- Sys.time()
# 
#     timeTaken1 = end_time - start_time
# 
# 
#   # second time
#     start_time <- Sys.time()
#     cache.components = data.cache(function() datafeed_components() , cache.name = 'components', frequency = daily, wait = FALSE)
#     end_time <- Sys.time()
# 
#     timeTaken2 = end_time - start_time
# 
# 
#   # this is the actual data
#     tail(DAX.components.Symbol)
#     # RWE (Energy)                           SAP (Software)        Siemens (Industrial, electronics) ThyssenKrupp (Industrial, manufacturing) 
#     # "RWE.DE"                                 "SAP.DE"                                 "SIE.DE"                                 "TKA.DE" 
#     # Volkswagen Group (Manufacturing)                    Vonovia (Real estate) 
#     # "VOW3.DE"                                 "VNA.DE" 
# 
#     # delete the cache (just in case there are any leftovers)
#     junk <- dir(path="~/cache/", pattern='components', full.names = TRUE) # ?dir
#     file.remove(junk) # ?file.remove
# 
#   # third time
#     start_time <- Sys.time()
#     cache.components = data.cache(function() datafeed_components() , cache.name = 'components', frequency = daily, wait = FALSE)
#     end_time <- Sys.time()
# 
#     timeTaken3 = end_time - start_time
# 
# 
#   # fourth time
#     start_time <- Sys.time()
#     cache.components = data.cache(function() datafeed_components() , cache.name = 'components', frequency = daily, wait = FALSE)
#     end_time <- Sys.time()
# 
#     timeTaken4 = end_time - start_time
# 
# 
#     # so retrieving the cache is significantly faster ...
#     # we assert that it is more the 30 times faster
#     assertthat::assert_that(timeTaken1>timeTaken2 * 30)
#     assertthat::assert_that(timeTaken3>timeTaken4 * 30)
# 
#     # in fact in this set up it is around 100
#     as.numeric(timeTaken1)/as.numeric(timeTaken2)
#     # [1] 45.29865
#     as.numeric(timeTaken3)/as.numeric(timeTaken4)
#     # [1] 43.57408
