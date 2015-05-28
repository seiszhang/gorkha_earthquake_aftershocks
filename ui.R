require('shiny', quietly = TRUE, warn.conflicts = FALSE)

fluidPage(
  
  titlePanel("Gorkha Earthquake & Aftershocks"),
  
  mainPanel(
    plotOutput('plot')
  )
)
