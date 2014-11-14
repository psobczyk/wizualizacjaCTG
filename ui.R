
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Centralne Twierdzenie Graniczne - zbieżność rozkładów"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("radio", label = h4("Wybór rozkładu"),
                   c("Normalny", "Wykładniczy", "Dwumianowy")),
      uiOutput("ui"),
      sliderInput("n",
                  h5("Wielkość próby - n"),
                  min = 1,
                  max = 100,
                  value = 30),
      sliderInput("m",
                  h5("Liczba prób dla histogramu - m"),
                  min = 5,
                  max = 1000,
                  value = 100)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tags$head( tags$script(src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML-full", type = 'text/javascript'),
                 tags$script( "MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});", type='text/x-mathjax-config')
      ),
      h4("Centralne Twierdzenie Graniczne"),
      p("Centralne Twierdzenie graniczne pozwala nam na",
        strong("przybliżenie"), "rozkładu
      średniej z próby rozkładem normalnym. To znaczy średnie z prób
        pochodzą", strong("w przybliżeniu"), "z rozkładu normalnego."),
      p("Zwizualizujemy teraz działanie tego twierdzenia.
        Procedura jaką wykonujemy wygląda następująco.
        Losujemy próbę wielkości", strong("n"), " z wybranego rozkładu", 
        HTML("$X_i,  i=1,...,n$"), 
        "Następnie liczymy średnią z próby",
        HTML("$\\frac{\\sum_{i=1}^n X_i}{n}$"),
        "Powyższe obliczenia powtarzamy", strong("m"), "razy.",
        "Wyniki przedstawiamy na histogramie."),
      plotOutput("distPlot"),
      p(strong("Centralne twierdzenie graniczne"),
        "mówi nam, że możemy przybliżać pewne rozkłady za pomocą rozkładu normalnego.",
        "Jak należy w praktyce myśleć o tym, że jakieś wartości pochodzą z danego
        rozkładu? W taki, że jeśli wylosujemy bardzo wiele liczb z tego rozkładu,
        ich liczba w powyższej symulacji jest dana przez parametr", strong("m"),
        "to ich histogram będzie bliski teoretycznemu histogramowi dla rozkładu
        normalnego."),
      h4("Uwaga"),
      p("Histogramy nie są idealnie dopasowane do teoretycznego rozkładu,
        nawet dla rozkładu normalnego, kiedy m jest nieduże.")
    )
  )
))
