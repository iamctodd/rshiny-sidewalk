library(leaflet)
library(ggplot2)
library(maps)


#source("data/BosBars.RData")
load("data/BosBars.RData")

# From a future version of Shiny


shinyServer(function(input, output, session) {
  
  # Create the map; this is not the "real" map, but rather a proxy
  # object that lets us control the leaflet map on the page.
  map <- createLeafletMap(session, 'map')
  
  observe({
    if (is.null(input$map_click))
      return()
    map$clearShapes()
  })
  
  radiusFactor <- 1000
  observe({
    map$clearShapes()

    if (nrow(cities) == 0)
      return()
      map$addCircleMarker(
      Bos.Bars$latitude, 
      Bos.Bars$longitude, 
      Bos.Bars$Sidewalk_Score/2, 
      layerId = NULL, 
      options = list(fill=TRUE, color='#A61212'), 
      eachOptions=list())
  })
  
  observe({
    event <- input$map_shape_click
    if (is.null(event))
      return()
    map$clearPopups()
    map$clearShapes()
    
    isolate({
      content <- as.character(Bos.Bars$name)
      map$showPopup(event$lat, event$lng, content)
    })
  })
  
  output$desc <- reactive({
    if (is.null(input$map_bounds))
      return(list())
    list(
      lat = mean(c(input$map_bounds$north, input$map_bounds$south)),
      lng = mean(c(input$map_bounds$east, input$map_bounds$west)),
      zoom = input$map_zoom,
    )
  })
  
  
  output$cityTimeSeries <- renderPlot({
    
  })
})




