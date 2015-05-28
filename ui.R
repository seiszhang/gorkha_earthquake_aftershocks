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
               ), 
               tabPanel("Time Intervals", 
                        fluidPage(
                          titlePanel("Inter-Quake Times"),
                          mainPanel(plotOutput('plot.inter.earthquake.time.from.4.25.to.5.12'),
                                    plotOutput('plot.inter.earthquake.time.from.5.13'))
                        )
               )
    )
  )
)
