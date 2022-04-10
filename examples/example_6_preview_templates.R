library(shiny)
library(imola)

# Helper function to generating a grid cell
gridCell <- function(text) {
  div(
    class = "cell",
    tags$label(text)
  )
}

# helper function to generate a template section
sectionDiv <- function(title, type, code, minimal, extended = NULL) {
  # tabsetPanel is finicky with null panels
  # so we build the list outside the function call
  tabs <- list(
    tabPanel("Preview (Mininum content)", minimal)
  )
  if (!is.null(extended)) {
    tabs <- c(tabs, list(tabPanel("Preview (additional content)", extended)))
  }
  tabs <- c(tabs, list(tabPanel("See Code Examples",
    tags$pre(tags$code(class = "language-r", code))
  )))

  div(
    class = "template-section",
    div(
      class = "template-preview",

      h1(title),

      p(tags$b("Type:"), type),
      p(tags$b("Template:"), title),

      do.call(tabsetPanel, c(list(type = "tabs"), tabs))
    )
  )
}

# Generate the UI for all the default imola flex templates
flex_templates <- lapply(names(listTemplates("flex")), function(template) {
  minimum_cells <- getOption("imola.templates")$flex[[template]]$attributes$basis$default
  display_cells <- length(minimum_cells)

  children <- list()
  for (index in seq_len(display_cells)) {
    children[[index]] <- gridCell(index)
  }

  extended_children <- list()
  for (index in seq_len(display_cells * 3)) {
    extended_children[[index]] <- gridCell(index)
  }

  sectionDiv(
    title = template,
    type = "flex",
    code = tagList(
      "# include the imola package",
      "library(imola)",
      "",
      "# Replace ... with the ui items you would like to include",
      "flexPanel(",
      paste0("  template = \"", template, "\","),
      "  ...",
      ")"
    ),
    minimal = do.call(
      flexPanel,
      modifyList(children, list(template = template))
    ),
    extended = do.call(
      flexPanel,
      modifyList(extended_children, list(template = template))
    )
  )
})

grid_templates <- lapply(names(listTemplates("grid")), function(template) {

  unique_areas <- unique(unlist(
    getOption("imola.templates")$grid[[template]]$attributes$areas
  ))

  children <- list()
  for (area in unique_areas) {
    children[[area]] <- gridCell(
      tags$label(area)
    )
  }

  sectionDiv(
    title = template,
    type = "grid",
    code = tagList(
      "# include the imola package",
      "library(imola)",
      "",
      "# Replace ... with the ui items you would like to include",
      "gridPanel(",
      paste0("  template = \"", template, "\","),
      "  ...",
      ")"
    ),
    minimal = do.call(
      gridPanel, modifyList(children, list(template = template))
    )
  )
})

dependencies <- tagList(
  tags$link(
    href = "https://fonts.googleapis.com/css?family=Lato",
    rel = "stylesheet"
  ),
  tags$link(href = "prism.css", rel = "stylesheet"),
  tags$link(href = "default-templates.css", rel = "stylesheet"),

  tags$script(
    src = "https://unpkg.com/trianglify@^4/dist/trianglify.bundle.js"
  ),
  tags$script(src = "prism.js"),
  tags$script(src = "default-templates.js"),
)

ui <- fixedPage(
  dependencies,
  div(id = "backgroundWrapper"),

  title = "Imola grid examples",
  h1("Imola Templates",
    style = "
      text-align: center;
      padding: 50px;
      font-size: 56px;
      color: #8200b0;
      font-weight: 900;
      border-bottom: 1px solid;
    "
  ),
  h3("A curated list of shiny dashboard layouts ",
    "that come bundled as templates with the the imola package",
    style = "
      text-align: center;
      padding: 40px 10%;
      font-weight: bold;
      color: #503558;
      line-height: 2;
    "
  ),

  h3("For more information about imola make sure to check the github ",
    a("repository",
      target = "_blank",
      href = "https://github.com/pedrocoutinhosilva/imola"
    ),
    style = "
      text-align: center;
      padding: 20px 25%;
      font-weight: bold;
      color: #503558;
      line-height: 2;
    "
  ),

  flex_templates,
  grid_templates
)

server <- function(input, output, session) {}

shinyApp(ui = ui, server = server)
