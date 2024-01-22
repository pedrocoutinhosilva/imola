library(shiny)
library(imola)
library(PeriodicTable)

elements <- PeriodicTable:::periodicTable

ui <- gridPage(
  tags$style("
    html, body {
        background: #2d2d2d;
    }
    .single-cell {
      display: flex;
      justify-content: center;
      align-items: center;
      position: relative;
      color: white;

      text-shadow:
        1px 1px 0 black,
        -1px 1px 0 black,
        -1px -1px 0 black,
        1px -1px 0 black;

    }

    .single-cell::before {
      content: '';
      display: block;
      padding-top: 100%;
    }

    .square .content {
      position: absolute;
      top: 0; left: 0;
      height: 100%;
      width: 100%;
    }


    .single-numb {
      position: absolute;
      top: 0.2vw;
      left: 0.2vw;
      font-size: 1vw;
    }

    .single-symb {
      font-size: 2vw;
    }

    .single-name {
      position: absolute;
      bottom: 0.2vw;
      font-size: 0.6vw;
      left: 0;
      right: 0;
      text-align: center;
    }
  "),
  style = "padding-top: 20px; justify-content: center; background: #2d2d2d",
  columns = "repeat(18, 5vw)",
  rows = "repeat(9, 5vw)",
  gap = "0.5vw",
  apply(elements, 1, function(element) {
    if (!is.na(element[["row"]])) {
      div(
        class = "single-cell",
        style = paste0("grid-row: ", element[["row"]], "; grid-column: ", element[["col"]], "; background: ", element[["color"]], ";"),
        `data-name` = element[["name"]],
        `data-numb` = element[["numb"]],
        `data-symb` = element[["symb"]],
        `data-mass` = element[["mass"]],
        `data-type` = element[["type"]],
        `data-discoverer` = element[["discoverer"]],
        `data-year` = element[["year"]],
        `data-color` = element[["color"]],
        div(
          class = "content",
          div(class = "single-numb", element[["numb"]]),
          div(class = "single-symb", element[["symb"]]),
          div(class = "single-name", element[["name"]])
        )
      )
    }
  }),
  HTML('
    <script src="https://unpkg.com/@popperjs/core@2"></script>
    <script src="https://unpkg.com/tippy.js@6"></script>
    <script src="periodic.js"></script>
  ')
)

server <- function(input, output, server) {
}

shinyApp(ui = ui, server = server)
