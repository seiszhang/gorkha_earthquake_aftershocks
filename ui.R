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
                          mainPanel(plotOutput('plot.inter.earthquake.time.from.2015.4.25.to.2015.5.12'),
                                    plotOutput('plot.inter.earthquake.time.from.2015.5.13'))
                        )
               )
    )
  )
)
