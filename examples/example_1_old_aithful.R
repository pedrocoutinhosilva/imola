library(shiny)
library(imola)

ui <- gridPage(
    title = "Grid page example",
    rows = "100px 1fr 1fr",
    areas = list(
      c("header", "header", "header"),
      c("sidebar", "main", "main"),
      c("sidebar", "main", "main")
    ),

    gridPanel(
      class = "header",
      areas = list(c("...", "title", "...")),
      div(
        class = "title",
        titlePanel("Old Faithful Geyser Data in a grid")
      )
    ),
    div(
      class = "sidebar",
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    gridPanel(
      class = "main",
      plotOutput("distPlot", height = "100%")
    )
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
