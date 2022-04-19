library(shiny)
library(imola)

breakpoint_system <- getBreakpointSystem()

breakpoint_system <- addBreakpoint(
  breakpoint_system,
  breakpoint("medium", max = 1000)
)

breakpoint_system <- addBreakpoint(
  breakpoint_system,
  breakpoint("small", max = 500)
)

divStyle <- function(color, border) {
  paste0(
    "background: ", color, "; ",
    "border: 10px solid ", border, ";"
  )
}

ui <- gridPage(
    title = "Grid page example",
    breakpoint_system = breakpoint_system,

    areas = list(
      default = list(
        c("header", "sidebar", "main"),
        c("header", "sidebar", "main")
      ),
      medium = c(
        "header header header",
        "sidebar main main"
      ),
      small = c(
        "header",
        "sidebar",
        "main"
      )
    ),

    header = div(
      style = divStyle("#FFD369", "#d48000"),
      tags$label("Example of custom media rules")
    ),

    sidebar = div(
      style = divStyle("#FFD369", "#d48000"),
      tags$label("Above 1000 px width we will be side by side")
    ),

    main = div(
      style = divStyle("#FFD369", "#d48000"),
      tags$label("Below 1000 and 500 pixels, the custom media points, we change layout")
    )
)

server <- function(input, output, session) {}

shinyApp(ui = ui, server = server)
