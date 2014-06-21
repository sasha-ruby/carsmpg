library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Fuel Consumption"),
    
    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(
            h3("Usage"),
            helpText("The application calculates average fuel consumption depending on numbers of cylinders and gears."),
            helpText("The impact of number of cylinders can be seen by changing the value using the slider in the Options section below."),
            helpText("The impact of number of gears can be seen by selecting different radio buttons in the Options section below."),
            helpText("Changing either of options reactively updates the chart with calculated average mpg, and positions the red line accordingly."),
            helpText("Data table is also filtered reactively, based on option selection."),
            br(),
            h3("Options"),
            sliderInput("cylinders", label=h5("Number of cylinders"), value=4, min=4, max=8, step=2),
            br(),
            radioButtons("gears", label = h5("Number of gears"), 
                         choices = list("3" = "3",
                                        "4" = "4",
                                        "5" = "5"
                         ), selected = "3")
            
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            h5(textOutput("inputParams")),
            br(),
            tabsetPanel(
                tabPanel("MPG vs Number of Cylinders",
                         plotOutput("plotmpgvscyl"),
                         p("Impact of number of cylinder on fuel consumption.")),
                tabPanel("MPG vs Number of Gears",
                         plotOutput("plotmpgvsgear"),
                         p("Impact of number of gears on fuel consumption.")),
                tabPanel("Data table",
                         dataTableOutput("cars"),
                         p("Impact of number of gears on fuel consumption."))
            ),
            br(),
            textOutput("min"),
            textOutput("max"),
            br()
        )
    )
))