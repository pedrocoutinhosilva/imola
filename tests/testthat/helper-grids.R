library(shiny)

# Retuns a html element to use for testing with specific colors
styled_div <- function(color, border, ...) {
  div(
    style = paste0(
      "background: ", color, "; ",
      "border: 10px solid ", border, ";",
      "min-height: 100px;"
    ),
    ...
  )
}

# Returns a generic example html element used for testing
test_item <- function() {
  styled_div("#FFD369", "#d48000")
}
