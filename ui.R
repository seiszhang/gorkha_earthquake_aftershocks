require('shiny', quietly = TRUE, warn.conflicts = FALSE)

shinyUI(
  fluidPage(
    titlePanel("Gorkha Earthquake & Aftershocks"),
    navbarPage("Visualizations: ", 
               tabPanel("Gorkha EQ Timeline", 
                        fluidPage(
                          titlePanel("Timeline"),
                          mainPanel(
                            verticalLayout(
                              plotOutput('plot.gorkha.earthquake.mag.in.timeline', 
                                         inline = TRUE),
                              plotOutput('plot.gorkha.earthquakes.mag.vs.datetime', 
                                         inline = TRUE)
                            )
                          )
                        )
               ), 
               tabPanel("Gorkha EQ Map",
                        fluidPage(titlePanel("Basic Map"), 
                                  mainPanel(
                                    verticalLayout(
                                      plotOutput('plot.gorkha.quakes.quakes.on.map', 
                                                 inline = TRUE)
                                    )
                                  )
                        )
               ), 
               tabPanel("Time Intervals", 
                        fluidPage(
                          titlePanel("Inter-Quake Times"),
                          mainPanel(plotOutput('plot.inter.earthquake.time.from.2015.4.25.to.2015.5.12', 
                                               inline = TRUE),
                                    plotOutput('plot.inter.earthquake.time.from.2015.5.13', 
                                               inline = TRUE))
                        )
               ), 
               tabPanel("All EQ in 2015", 
                        fluidPage(
                          titlePanel("All EQ in 2015"),
                          mainPanel(
                            verticalLayout(
                              plotOutput('plot.all.earthquakes.mag.in.timeline', 
                                         inline = TRUE),
                              plotOutput('plot.all.earthquakes.mag.vs.datetime', 
                                         inline = TRUE)
                            )
                          )
                        )
               )
    )
  )
)
