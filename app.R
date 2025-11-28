#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(dplyr)
library(ggplot2)
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Starwars"),
    h1("Star Wars Characters"),
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "taille",
                        label = "Height of characters",
                        min = 0,
                        max = 250,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput(outputId = "StarWarsPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$StarWarsPlot <- renderPlot({
      starwars |> 
        filter(height > input$taille) |>
        ggplot(aes(x = height)) +
        geom_histogram(
          binwidth = 10, 
          fill = "darkgray", 
          color = "white"
        )
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
