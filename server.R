library(shiny)
library(doBy)

data(mtcars)
mn <- mean(mtcars$mpg)

mnv <- summaryBy(mpg ~ cyl + gear, data=mtcars, FUN=c(mean))
optMin <- subset(mnv, mpg.mean == min(mnv$mpg.mean))
optMax <- subset(mnv, mpg.mean == max(mnv$mpg.mean))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    mns <- reactive({
        mtcarsSub <- subset(mtcars, cyl == input$cylinders & gear == input$gears)
        mea <- mean(mtcarsSub$mpg)
        return(mea)
    })
    
    output$cars <- renderDataTable({
        subset(mtcars, cyl == input$cylinders & gear == input$gears)
    })
    
    output$plotmpgvscyl <- renderPlot({
        plot(mtcars$cyl, mtcars$mpg, col="blue", xlab = "Number of cylinders", ylab = "Miles per gallon")
        lines(c(4, 8), c(mn, mn), col="darkgrey", lwd=2)
        lines(c(4, 8), c(mns(), mns()), col="red", lwd=2)
    })

    output$plotmpgvsgear <- renderPlot({
        plot(mtcars$gear, mtcars$mpg, col="blue", xlab = "Number of gears", ylab = "Miles per gallon")
        lines(c(3, 5), c(mn, mn), col="darkgrey", lwd=2)
        lines(c(3, 5), c(mns(), mns()), col="red", lwd=2)
    })
    
    output$min <- renderText({
        paste("Minimum fuel consumption of ", optMin$mpg.mean, " have cars with ", optMin$cyl, " cylinders and ", 
              optMin$gear, " gears.")
    })

    output$max <- renderText({
        paste("Minimum fuel consumption of ", optMax$mpg.mean, " have cars with ", optMax$cyl, " cylinders and ", 
          optMax$gear, " gears.")
})

output$inputParams <- renderText({
        paste("Average fuel consumption for a car with ", 
              input$cylinders, " cylinders and ", input$gears, " gears is ", mns(), " miles per gallon.")
    })

})