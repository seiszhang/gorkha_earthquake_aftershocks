require('shiny', quietly = TRUE, warn.conflicts = FALSE)
require('lubridate', quietly = TRUE, warn.conflicts = FALSE)

function(input, output) {
  
  output$plot.all.earthquakes.mag.in.timeline <- renderPlot({
    plot.earthquake.mag.in.timeline(earthquakes)
  }, width = 960, height = 540)
  
  output$plot.all.earthquakes.mag.vs.datetime <- renderPlot({
    plot.earthquake.mag.vs.datetime(earthquakes)
  }, width = 960, height = 540)
  
  output$plot.gorkha.earthquake.mag.in.timeline <- renderPlot({
    plot.earthquake.mag.in.timeline(earthquakes.from.2015.4.25)
  }, width = 960, height = 540)
  
  output$plot.gorkha.earthquakes.mag.vs.datetime <- renderPlot({
    plot.earthquake.mag.vs.datetime(earthquakes.from.2015.4.25)
  }, width = 960, height = 540)
  
  output$plot.inter.earthquake.time.from.2015.4.25.to.2015.5.12 <- renderPlot({
    plot.inter.earthquake.time.from.2015.4.25.to.2015.5.12()
  }, width = 640, height = 360)
  
  output$plot.inter.earthquake.time.from.2015.5.13 <- renderPlot({
    plot.inter.earthquake.time.from.2015.5.13()
  }, width = 640, height = 360)
  
  # output$plot.gorkha.quakes.quakes.on.map <- renderPlot({
  #   plot.gorkha.quakes.quakes.on.map()
  # }, width = 640, height = 360)
  
  output$leaflet.plot.gorkha.quakes.quakes.on.map <- 
    renderLeaflet(leaflet.plot.gorkha.quakes.quakes.on.map())
  
  animate.map.day.slider.data <- reactive({
    ifelse(is.integer(input$animate.map.day.slider), 
           input$animate.map.day.slider, 
           0)
  })

  output$animate.map.date.to <- renderText({
    (lubridate::ymd("2015-04-25", tz = "Asia/Kathmandu") + 
       lubridate::days(animate.map.day.slider.data())) %>% 
      as.character()
  })
  
  output$ui.animate.map.day.slider <- renderUI({
    sliderInput(inputId = "animate.map.day.slider", 
                label = "Days: ", 
                min = 0, max = difftime(time1 = Sys.Date() %>% 
                                  as.POSIXct(), 
                                  time2 = lubridate::ymd("2015-04-25"), 
                                  units = "days") %>% 
                  ceiling() %>% 
                  as.integer(), 
                value = 0, step = 1, 
                animate = animationOptions(interval = 500, loop = TRUE))
  })
  
  output$animate.map.plot <- renderPlot({
    (lubridate::ymd("2015-04-25", tz = "Asia/Kathmandu") + 
       lubridate::days(animate.map.day.slider.data()) + 
       lubridate::hms("23:59:59")) %>% 
      plot.gorkha.quakes.to.date()
  })
}
