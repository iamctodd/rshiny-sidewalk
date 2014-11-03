library(leaflet)
library(ShinyDash)
library(ggvis)

load("data/BosBars.RData")

shinyUI(fluidPage(
  tags$head(tags$link(rel='stylesheet', type='text/css', href='styles.css')),
  leafletMap(
    "map", "100%", 400,
    initialTileLayer = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
    initialTileLayerAttribution = HTML('Maps by <a href="http://www.mapbox.com/">Mapbox</a>'),
    options=list(
      center = c(42.3581, -71.0636),
      zoom = 14,
      maxBounds = list(list(17, -180), list(59, 180))
    )
  ),
  fluidRow(
    column(12, offset=0,
      h2('Influential Bars in Boston'),
      htmlWidgetOutput(
        outputId = 'desc',
        HTML(paste(
          'The map is centered at <span id="lat"></span>, <span id="lng"></span>',
          'with a zoom level of <span id="zoom"></span>.<br/>',
          'Data courtesy of <a href="http://getsidewalk.com">Sidewalk</a>'
        ))
      )
    )
  ),
  hr(),
  fluidRow(
    column(3,
      h4('Select Scatterplot Variables'),
      selectInput('xvar', 'X-axis variable', choices=colnames(Bos.Bars, do.NULL = TRUE, prefix = "col")),
      selectInput('yvar', 'Y-axis variable', choices=colnames(Bos.Bars, do.NULL = TRUE, prefix = "col")),
    ),
    
    column(9,
      h4('Scatterplot'),
 #     plotOutput('', width='100%', height='300px'),
 #     ggvisOutput("plot1")
    )
  )
))
