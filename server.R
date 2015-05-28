require('shiny', quietly = TRUE, warn.conflicts = FALSE)
require('ggplot2', quietly = TRUE, warn.conflicts = FALSE)
require('scales', quietly = TRUE, warn.conflicts = FALSE)

function(input, output) {
  
  output$plot <- renderPlot({
    plot.earthquake.mag.vs.datetime()
  }, width = 960, height = 540)
  
}
