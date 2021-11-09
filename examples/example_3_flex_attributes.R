library(shiny)
library(imola)
library(magrittr)

registerTemplate("flex", "mycustom",
                 direction = "column")

exampleDiv <- function(color, border, ...) {
  div(
    style = paste0(
      "background: ", color, "; ",
      "border: 10px solid ", border, ";",
      "min-height: 100px;"
    ),
    ...
  )
}

exampleTitle <- function(...) {
  h4(..., style = "border-top: 1px solid; padding-top: 15px;")
}

ui <- gridPage(
    title = "Flex page example",

    columns = list(
      default = "1fr 1fr 1fr",
      lg = "1fr 1fr",
      xs = "1fr",
      xs = "1fr"
    ),

    gap = "20px",
    style = "padding: 20px",

    flexPanel(
      direction = "column",
      flex = c("auto", 1),

      exampleTitle("Default flex box"),
      flexPanel(
        exampleDiv("#FFD369", "#d48000"),
        exampleDiv("#FFD369", "#d48000"),
        exampleDiv("#FFD369", "#d48000")
      )
    ),

    flexPanel(
      template = "mycustom",
      flex = c("auto", 1),

      exampleTitle("Gap only"),
      flexPanel(
        gap = "10px",

        exampleDiv("#D3FF69", "#80d400"),
        exampleDiv("#D3FF69", "#80d400"),
        exampleDiv("#D3FF69", "#80d400")
      )
    ),

    flexPanel(
      direction = "column",
      flex = c("auto", 1),

      exampleTitle("Set basis of 150px, shrink below that not allowed"),
      flexPanel(
        gap = "10px",

        basis = c("150px"),
        shrink = c(0),

        exampleDiv("#3DFF69", "#084d00"),
        exampleDiv("#3DFF69", "#084d00"),
        exampleDiv("#3DFF69", "#084d00")
      )
    ),

    flexPanel(
      direction = "column",
      flex = c("auto", 1),

      exampleTitle("Set basis of 150px, grow above that not allowed"),
      flexPanel(
        gap = "10px",

        basis = c("150px"),
        grow = c(0),

        exampleDiv("#3DFF69", "#084d00"),
        exampleDiv("#3DFF69", "#084d00"),
        exampleDiv("#3DFF69", "#084d00")
      )
    ),

    flexPanel(
      direction = "column",
      flex = c("auto", 1),

      exampleTitle("Set basis of 150px, grow above that not allowed, no wrapping"),
      flexPanel(
        gap = "10px",

        wrap = "no-wrap",
        basis = c("150px"),
        grow = c(0),

        exampleDiv("#3DFF69", "#084d00"),
        exampleDiv("#3DFF69", "#084d00"),
        exampleDiv("#3DFF69", "#084d00")
      )
    ),

    flexPanel(
      direction = "column",
      flex = c("auto", 1),

      exampleTitle("Diferent basis per element (150px, 100px, 50px)"),
      flexPanel(
        gap = "10px",

        basis = c("150px", "100px", "50px"),

        exampleDiv("#3DFF69", "#084d00"),
        exampleDiv("#3DFF69", "#084d00"),
        exampleDiv("#3DFF69", "#084d00")
      )
    ),

    flexPanel(
      direction = "column",
      flex = c("auto", 1),

      exampleTitle("One static size, two flex"),
      flexPanel(
        gap = "10px",

        basis = c("150px", NA, "200px"),
        grow = c(0, 1, 1),
        shrink = c(0, 1, 1),

        exampleDiv("#3DFF69", "#084d00"),
        exampleDiv("#3DFF69", "#084d00"),
        exampleDiv("#3DFF69", "#084d00")
      )
    ),

    flexPanel(
      direction = "column",
      flex = c("auto", 1),

      exampleTitle("Default flex box"),
      flexPanel(
        exampleDiv("#D3FF69", "#80d400"),
        exampleDiv("#D3FF69", "#80d400"),
        exampleDiv("#D3FF69", "#80d400")
      )
    ),

    flexPanel(
      direction = "column",
      flex = c("auto", 1),

      exampleTitle("Responsive with gap"),
      flexPanel(
        gap = list(
          default = "50px",
          md = "25px",
          xs = "5px"
        ),

        exampleDiv("#D369FF", "#8000d4"),
        exampleDiv("#D369FF", "#8000d4"),
        exampleDiv("#D369FF", "#8000d4")
      )
    )
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)
