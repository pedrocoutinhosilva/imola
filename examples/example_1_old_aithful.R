library(shiny)
library(imola)

ui <- gridPage(
    title = "Grid page example",

    rows = "100px minmax(0, 1fr) minmax(0, 1fr)",
    columns = "minmax(200px, 1fr) minmax(0, 1fr) minmax(0, 1fr)",

    areas = list(
      c("header", "header", "header"),
      c("sidebar", "main", "main"),
      c("sidebar", "main", "main")
    ),

    header = gridPanel(
      areas = list(c("...", "title", "...")),
      div(
        class = "title",
        titlePanel("Old Faithful Geyser Data in a grid")
      )
    ),
    sidebar = div(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    main = plotOutput("distPlot", height = "100%")
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
      test = 'darkgray'

      x    <- faithful[, 2]
      bins <- seq(min(x), max(x), length.out = input$bins + 1)

      hist(x, breaks = bins, col = test, border = 'white')
  })
}

shinyApp(ui = ui, server = server)
