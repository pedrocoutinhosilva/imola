# remotes::install_github("ColinFay/brochure")

library(shiny)
library(imola)
library(magrittr)
library(brochure)

examples <- list.files(pattern = "example_")

brochure_page_overwrites <- tags$style("
  .container-fluid {
    width: 100% !important;
    margin: 0 !important;
    padding: 0 !important;
  }
")


for (example in examples) {
  source(example)
}

nav_links <- div(
  style = "
    position: fixed;
    bottom: 10px;
    left: 10px;
    margin: auto;
    height: fit-content;
    background: white;
    border: 2px solid;
    font-size: 120%;
    padding: 10px;
    border-radius: 10px;
  ",
  h2("Other examples", style = "margin-top: 0;"),

  div(
    tags$a(href = "/", "home"),
  ),
  lapply(examples, function(example) {
    div(
      tags$a(href = example, example),
    )
  })
)

example_page <- function(name, ui, server) {

  if (name == "") {
    ui <- tagList(
      brochure_page_overwrites,
      h2("Examples from the imola package"),
      ui,
      a(
        href = "https://github.com/pedrocoutinhosilva/imola/tree/main/examples",
        h3("Explore the code at https://github.com/pedrocoutinhosilva/imola/tree/main/examples")
      ),
      tags$style("
        .container-fluid {
          display: flex;
          justify-content: center;
          align-items: center;
          flex-direction: column;
          min-height: 100vh;
          font-size: 150%;
        }
      ")
    )
  } else {
    ui <- tagList(
      brochure_page_overwrites,
      nav_links,
      ui
    )
  }

  page(
    href = paste0("/", name),
    ui =  ui,
    server = server
  )
}

example_pages <- lapply(examples, function(example) {
  cmds <- parse(example)

  page <- list(
    ui = NULL,
    server = NULL
  )

  for (x in cmds) {
    if (x[[1]] == "<-") {
      if (x[[2]] == "ui") {
        page$ui <- eval(x[[3]])
      }

      if (x[[2]] == "server") {
        page$server <- eval(x[[3]])
      }
    }
  }

  example_page(example, page$ui, page$server)
})

shinyApp <- function() {
  do.call(brochure::brochureApp, c(
    list(
      example_page(
        "",
        tagList(
          lapply(examples, function(example) {
            div(
              tags$a(href = example, example),
            )
          })
        ),
        function(input, output, session) {}
      )
    ),
    example_pages
  ))
}
shinyApp()
