require('shiny', quietly = TRUE, warn.conflicts = FALSE)
require('ggplot2', quietly = TRUE, warn.conflicts = FALSE)
require('scales', quietly = TRUE, warn.conflicts = FALSE)

function(input, output) {
  
  output$plot <- renderPlot({
    
    p <- ggplot(data = earthquakes, 
                mapping = aes(x = time_posixct, y = mag, size = mag), 
                height = 960, width = 540) + 
      geom_point() + 
      scale_x_datetime("Time of Day", breaks = date_breaks("3 hour"),
                       labels = date_format("%H:%M")) + 
      scale_y_continuous("Magnitude") + 
      facet_wrap(~date, ncol = 7) + 
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
    
    print(p)
  }, width = 960, height = 540)
  
}
