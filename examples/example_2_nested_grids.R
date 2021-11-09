library(shiny)
library(imola)

divStyle <- function(color, border) {
  paste0(
    "background: ", color, "; ",
    "border: 10px solid ", border, ";"
  )
}

ui <- gridPage(
    title = "Grid Panels example",
    # fill_page = FALSE,
    # auto_fill = FALSE,

    rows = list(
      default = "100px 2fr 3fr",
      xs = "100px 1fr 1fr"
    ),
    areas = list(
      default = c(
        "area-1 area-1 area-1",
        "area-2 area-3 area-3",
        "area-2 area-3 area-3"
      ),
      xs = c(
        "area-1",
        "area-2",
        "area-3"
      )
    ),
    gap = list(
      default = "5px",
      md = "10px",
      xs = "15px"
    ),

    div(
      class = "area-1",
      style = divStyle("#FFD369", "#d48000"),
      tags$label("Im just a div")
    ),

    gridPanel(
      class = "area-2",
      style = divStyle("#FFD369", "#d48000"),
      tags$label("Im just a grid panel replacing a div")
    ),

    gridPanel(
      class = "area-3",
      rows = "1fr 1fr 5fr",
      columns = "1fr 1fr 5fr",
      style = divStyle("#FFD369", "#d48000"),

      areas = c(
        "subarea-1 subarea-1 subarea-3",
        "subarea-1 subarea-1 subarea-3",
        "subarea-2 subarea-2 subarea-3"
      ),

      div(
        class = "subarea-1",
        style = divStyle("#cacaca", "gray"),
        tags$label("A grid panel with a inner grid")
      ),
      `subarea-2` = div(
        style = divStyle("#cacaca", "gray"),
        tags$label("I dont have the right area class, but im called as a named argument so its fine")
      ),
      gridPanel(
        class = "subarea-3",
        style = divStyle("#4c4c4c", "gray"),

        areas = list(
          default = c(
            "subsubarea-1",
            "subsubarea-2",
            "subsubarea-3"
          ),
          xs = c(
            "subsubarea-1 subsubarea-1",
            "subsubarea-2 subsubarea-3"
          )
        ),

        gap = list(
          default = "0",
          xs = "5%"
        ),

        div(
          class = "subsubarea-1",
          style = divStyle("#71A5FF", "blue"),

          tags$label("We need to go deeper")
        ),
        div(
          class = "subsubarea-2",
          style = divStyle("#72E7E8", "blue"),
          `data-test-attribute` = "just a test attribute",
          tags$label("I have a custom data attribute, just like a normal div")
        ),
        gridPanel(
          class = "subsubarea-3",
          style = divStyle("#8AFFB1", "blue"),
          rows = "repeat(4, 1fr)",

          div(style = "background: #8AFF91; border: 3px solid green;"),
          div(style = "background: #8AFF81; border: 3px solid green;"),
          div(style = "background: #8AFF71; border: 3px solid green;"),
          gridPanel(
            style = "background: #8AFF61; border: 3px solid green;",
            columns = "1fr 1fr 1fr",

            div(style = "background: #8A1F91; border: 2px solid yellow;"),
            div(style = "background: #8A2F81; border: 2px solid yellow;"),
            div(style = "background: #8A3F71; border: 2px solid yellow;")
          )
        )
      )
    )
)

server <- function(input, output) {
}

shinyApp(ui = ui, server = server)
