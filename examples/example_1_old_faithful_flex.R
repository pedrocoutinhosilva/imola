library(shiny)
library(imola)

ui <- flexPage(
    title = "Grid page example",

    wrap = "wrap",
    basis = c("100%", "20%", "80%"),

    div(
      style = "height: 100px; text-align: center;",
      titlePanel("Old Faithful Geyser with flex")
    ),

    sliderInput("bins",
      "Number of bins:",
      min = 1,
      max = 50,
      value = 30
    ),

    plotOutput("distPlot")
)

server <- function(input, output, server) {
  output$distPlot <- renderPlot({
      x    <- faithful[, 2]
      bins <- seq(min(x), max(x), length.out = input$bins + 1)

      hist(x, breaks = bins, col = "darkgray", border = "white")
  })
}

shinyApp(ui = ui, server = server)
