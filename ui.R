require('shiny', quietly = TRUE, warn.conflicts = FALSE)

shinyUI(
  fluidPage(
    titlePanel("Gorkha Earthquake & Aftershocks"),
    navbarPage("Visualizations: ", 
               tabPanel("Timeline", 
                        fluidPage(
                          titlePanel("Timeline"),
                          mainPanel(
                            plotOutput('plot')
                          )
                        )
               )
    )
  )
)
