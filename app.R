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
                        value = 30),
            selectInput(
              inputId = "sexe",
              label = "Choisissez le genre",
              choices = c("masculine","feminine")
            )
        ),
        # Show a plot of the generated distribution
        mainPanel(
          textOutput(outputId = "nbperso"),
          plotOutput(outputId = "StarWarsPlot"),
          DT::DTOutput(outputId = "tableau")
        )
        
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$nbperso <- renderText({
      n <- starwars |> 
        filter(height > input$taille & gender == input$sexe) |>
        nrow()
      paste("Nombre de personnages sélectionnés :", n)
    })
    
    output$StarWarsPlot <- renderPlot({
      starwars |> 
        filter(height > input$taille & gender == input$sexe) |>
        ggplot(aes(x = height)) +
        geom_histogram(
          binwidth = 10, 
          fill = "darkgray", 
          color = "white"
        )+
        labs(
          title = paste("Graphique filtré par ",input$sexe)
        )
    })
    
    output$tableau <- DT::renderDT({
      starwars |> 
        filter(height > input$taille & gender == input$sexe)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
