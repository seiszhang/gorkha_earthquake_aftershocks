require('shiny', quietly = TRUE, warn.conflicts = FALSE)

function(input, output) {
  
  output$plot.all.earthquakes <- renderPlot({
    plot.earthquake.mag.in.timeline(earthquakes)
  }, width = 960, height = 540)

  output$plot <- renderPlot({
    plot.earthquake.mag.vs.datetime(earthquakes)
  }, width = 960, height = 540)
  
  output$plot.inter.earthquake.time.from.2015.4.25.to.2015.5.12 <- renderPlot({
    plot.inter.earthquake.time.from.2015.4.25.to.2015.5.12()
  }, width = 640, height = 360)
  
  output$plot.inter.earthquake.time.from.2015.5.13 <- renderPlot({
    plot.inter.earthquake.time.from.2015.5.13()
  }, width = 640, height = 360)
}
