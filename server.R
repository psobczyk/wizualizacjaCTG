
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  output$ui <- renderUI({
    if (is.null(input$radio))
      return()
    
    # Depending on input$input_type, we'll generate a different
    # UI component and send it to the client.
    switch(input$radio,
           "Wykładniczy" = sliderInput("dynamic", HTML("Parametr &lambda;:"),
                                       min = 0.1, max = 5, value = 1, step=0.1),
           "Normalny" = sliderInput("dynamic", "Wartość oczekiwana",
                                    min = -5, max = 5, value = 0, step=1),
           "Dwumianowy" =  sliderInput("dynamic", "Parametr p",
                                       min = 0.05, max = 0.95, value = 0.5, step=0.05),
    )
  })
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    print(input$dynamic)
    print(input$n)
    if ( (input$radio == "Wykładniczy") & (input$dynamic>0)) 
        x <- vapply(1:input$m, function(dummy) mean(rexp(input$n, input$dynamic)), 0.1)
    else if (input$radio == "Normalny") 
      x <- vapply(1:input$m, function(dummy) mean(rnorm(input$n, input$dynamic, 1)), 0.1)
    else if (input$radio == "Dwumianowy" & (input$dynamic >0 & input$dynamic <1) ) 
       x <- vapply(1:input$m, function(dummy) rbinom(1, input$n, input$dynamic)/input$n, 0.1)   
    
    # draw the histogram with the specified number of bins
    if (any(is.na(x)))
      return()
    
    srednia <- mean(x)
    odchylenie <- sd(x)
    hist(x, freq = F, ylab = "gęstość", col = "lightblue",
         ylim = c(0, dnorm(srednia, mean = srednia, sd = odchylenie)),
         main = (paste0("Histogram dla rozkładu ", input$radio)))
    curve(dnorm(x,mean = srednia, sd = odchylenie), add=TRUE,lwd=2,col="red")
    legend("topright", 
           legend = c("Histogram dla próby", "Gęstość rozkładu normalnego"),
           fill = c("lightblue", "red"))
  })
  
})
