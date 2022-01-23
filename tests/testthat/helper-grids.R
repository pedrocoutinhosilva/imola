library(shiny)

# Retuns a html element to use for testing with specific styles
styled_div <- function(color, border, ...) {
  div(
    style = paste0(
      "background: ", color, "; ",
      "box-shadow: inset 0px 0px 0px 10px ", border, ";",
      "min-height: 100px;",
      "display: flex;",
      "justify-content: center;",
      "align-items: center;"
    ),
    ...
  )
}

# Returns a generic example html element used for testing
test_item <- function(...) {
  styled_div("#FFD369", "#d48000", ...)
}

# finds a html tag fia a valid css selector in a shiny.tag object
find_html_node <- function(input, selector) {
   input %>%
    toString() %>%
    rvest::read_html() %>%
    rvest::html_elements(selector)
}
