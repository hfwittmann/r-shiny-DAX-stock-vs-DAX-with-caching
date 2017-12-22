# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # Return the requested dataset
  datasetInput <- reactive({
    
      # get DAX data
      varName1 = '^GDAXI'
      cache.stockdata = data.cache(function() datafeed_timeseries(varName1) , cache.name = varName1, frequency = daily, wait = FALSE)
      
      # get stock data
      varName2 = input$stock_id
      cache.stockdata = data.cache(function() datafeed_timeseries(varName2) , cache.name = varName2, frequency = daily, wait = FALSE)
      
      # get from environment
      stockdata.thisstock = get(paste0('stockdata.', input$stock_id))
      
      # merge DAX plut selected Stock
      stockdata = merge (`stockdata.^GDAXI`, stockdata.thisstock)
      
      no_of_datapoints = dim(stockdata)[1]
      
      min = input$range[1]/100 * no_of_datapoints
      max = input$range[2]/100 * no_of_datapoints
      
      # AdjustedPrice
      out = stockdata[min:max,]
      
      return (out)
  })
  
  
  # generate a plot
  output$timeseries <- renderPlot({

    AdjustedPrice <- datasetInput()
    
    Returns <- AdjustedPrice/lag(AdjustedPrice, 1) -1
    charts.PerformanceSummary(Returns)
    
  })
  
  output$histogram.GDAXI <- renderPlot({
    
    AdjustedPrice <- datasetInput()[,1,drop=FALSE]
    Returns <- AdjustedPrice/lag(AdjustedPrice, 25) -1
    
    chart.Histogram(Returns, methods = c( "add.density", "add.normal"), xlim = c(-0.4, 0.4))
    
  })
  
  output$histogram.stockdata <- renderPlot({
    
    AdjustedPrice <- datasetInput()[,2,drop=FALSE]
    Returns <- AdjustedPrice/lag(AdjustedPrice, 25) -1
    
    chart.Histogram(Returns, methods = c( "add.density", "add.normal"), xlim = c(-0.4, 0.4))
    
  })
  
  output$boxplot <- renderPlot({
    
    AdjustedPrice <- datasetInput()
    Returns <- AdjustedPrice/lag(AdjustedPrice, 25) -1
    
    chart.Boxplot(Returns)
    
  })
  

})
