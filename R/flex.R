#' Create a flexbox based panel
#'
#' @param ... Tag attributes (named arguments) and children (unnamed arguments).
#'   A named argument with an `NA` value is rendered as a boolean attributes.
#'   Named arguments can be used to provide additional values to the container
#'   of the grid.
#'
#'   For a full list of valid HTML attributes check visit
#'   \url{https://www.w3schools.com/tags/ref_attributes.asp}.
#'
#'   Children may include any combination of:
#'   * Other tags objects
#'   * [HTML()] strings
#'   * [htmlDependency()]s
#'   * Single-element atomic vectors
#' @param template The name of the template to use as a base for the grid, or
#'   the resulting value from using makeTemplate() to generate a template
#'   object.
#'
#'   See `listTemplates()` and `registerTemplate()` for more information.
#' @param direction Direction of the flow of elements in the panel.
#'
#'   Accepts a valid css `flex-direction` value (`row` | `row-reverse` |
#'    `column` | `column-reverse`).
#'
#'   By default the `row` value is used. Supports breakpoints.
#' @param wrap Should elements be allowed to wrap into multiple lines.
#'
#'   Accepts a valid css `flex-wrap` value (`nowrap` | `wrap` | `wrap-reverse`).
#'
#'   By default the value `wrap` is used. Supports breakpoints.
#' @param justify_content Defines the alignment along the main axis. Accepts a
#'   valid css `justify-content` value (`flex-start` | `flex-end` | `center` |
#'   `space-between` | `space-around` | `space-evenly` | `start` |
#'    `end` | `left` | `right`).
#'
#'   By default the value `flex-start` is used. Supports breakpoints.
#' @param align_items Defines the default behavior for how flex items are laid
#'   out along the cross axis on the current line.
#'
#'   Accepts a valid css `align-items` value (`stretch` | `flex-start` |
#'    `flex-end` | `center` | `baseline` | `first baseline` | `last baseline` |
#'    `start` | `end` | `self-start` | `self-end`).
#'
#'   By default the value `stretch` is used. Supports breakpoints.
#' @param align_content Aligns a flex container’s lines within when there is
#'   extra space in the cross-axis.
#'
#'   Accepts a valid css `align-content` value
#'   (flex-start | flex-end | center | space-between | space-around |
#'   space-evenly | stretch | start | end | baseline | first baseline |
#'   last baseline).
#'
#'   By default the value 'flex-start' is used. Supports breakpoints.
#' @param gap Defines the space between elements in the panel. Controls both the
#'   space between rows and columns.
#'
#'   Accepts a css valid value, or 2 values separated by a space (if using
#'   diferent values for row and column spacing).
#'
#'   By default the value `0` is used. Supports breakpoints.
#' @param flex A vector of valid css 'flex' values for the child elements.
#'   Defines how elements in the panel can grow, shrink and their initial size.
#'
#'   Arguments that target child elements individually require a vector of
#'   values instead of a single value, with each entry of the vector affecting
#'   the nth child element.
#'
#'   If the given vector has less entries that the number
#'   of child elements, the values will be repeated until the pattern affects
#'   all elements in the panel. If the number of entries given is more that the
#'   number of child elements, exceeding entries will be ignored. NA can also be
#'   used as a entry to skip adding a rule to a specific nth element.
#'
#'   Accepts a valid css `flex` value.
#'
#'   By default c(1) is used, meaning all elements can grow and shrink as
#'   required, at the same rate. Supports breakpoints.
#' @param grow A vector of valid css 'flex-grow' values. Defines the rate of
#'   how elements can grow. Entries will overwrite the nth 'flex' value,
#'   and can be used make more targeted rules.
#'
#'   Entries will overwrite the 'flex' values, and can
#'   be used make more targeted rules.
#'
#'   Arguments that target child elements individually require a vector of
#'   values instead of a single value, with each entry of the vector affecting
#'   the nth child element.
#'
#'   If the given vector has less entries that the number
#'   of child elements, the values will be repeated until the pattern affects
#'   all elements in the panel. If the number of entries given is more that the
#'   number of child elements, exceeding entries will be ignored. NA can also be
#'   used as a entry to skip adding a rule to a specific nth element.
#'
#'   By default NULL is used, meaning values from the flex argument will be
#'   used instead. Supports breakpoints.
#' @param shrink A vector of valid css 'flex-shrink' values. Defines the rate
#'   of how elements can shrink. Entries will overwrite the nth 'flex' value,
#'   and can be used make more targeted rules.
#'
#'   Arguments that target child elements individually require a vector of
#'   values instead of a single value, with each entry of the vector affecting
#'   the nth child element.
#'
#'   If the given vector has less entries that the number
#'   of child elements, the values will be repeated until the pattern affects
#'   all elements in the panel. If the number of entries given is more that the
#'   number of child elements, exceeding entries will be ignored. NA can also be
#'   used as a entry to skip adding a rule to a specific nth element.
#'
#'   By default NULL is used, meaning values from the flex argument will be
#'   used instead. Supports breakpoints.
#' @param basis  A vector of valid css 'flex-basis' values. Defines the base
#'   size of elements. Entries will overwrite the nth 'flex' value,
#'   and can be used make more targeted rules.
#'
#'   Arguments that target child elements individually require a vector of
#'   values instead of a single value, with each entry of the vector affecting
#'   the nth child element.
#'
#'   If the given vector has less entries that the number
#'   of child elements, the values will be repeated until the pattern affects
#'   all elements in the panel. If the number of entries given is more that the
#'   number of child elements, exceeding entries will be ignored. NA can also be
#'   used as a entry to skip adding a rule to a specific nth element.
#'
#'   By default NULL is used, meaning values from the flex argument will be
#'   used instead. Supports breakpoints.
#' @param breakpoint_system Optional Media breakpoints to use. Will default to
#'   the current active breakpoint system.
#' @param id The panel id. A randomly generated one is used by default.
#'   You cannot have more than one element with the same id in an HTML document.
#'
#' @details Behaves similar to a normal HTML tag, but provides helping
#'   arguments that simplify the way flexbox css can be created from shiny.
#'
#' @note When creating responsive layouts based on media rules, for most css
#'   arguments a named list can be passed instead of a single value.
#'
#'   The names in the list can be any of the registered breakpoints available in
#'   `getBreakpointSystem()`, of on the provided `breakpoint_system` argument.
#'   Current global `getBreakpointSystem()` can be changed using
#'   `setActiveBreakpointSystem()`.
#'
#'   In a similar fashion, the current `getBreakpointSystem()` can also be
#'   modified with the `registerBreakpoint()` and `unregisterBreakpoint()`.
#'
#'   It is recomended to define the breakpoint system for the application
#'   globally before UI definitions, but the `breakpoint_system` in panel
#'   functions allows for more flexibility when it comes to reuse components
#'   from other projects.
#'
#' @note See
#'   \url{https://css-tricks.com/snippets/css/a-guide-to-flexbox/}
#'   for additional details on using css flexbox
#'
#' @family flexbox functions
#' @seealso [flexPage()]
#'
#' @examples
#' if (interactive()) {
#' library(shiny)
#' library(imola)
#' flexPanel(
#'   div("example content"),
#'   div("example content"),
#'   div("example content")
#' )
#' }
#'
#' @importFrom magrittr "%>%"
#' @importFrom htmltools HTML
#'
#' @return An HTML tagList.
#' @keywords flex panel
#' @export
flexPanel <- function(...,
                      template = NULL,
                      direction = "row",
                      wrap = "nowrap",
                      justify_content = "flex-start",
                      align_items = "stretch",
                      align_content = "flex-start",
                      gap = 0,
                      flex = c(1),
                      grow = NULL,
                      shrink = NULL,
                      basis = NULL,
                      breakpoint_system = getBreakpointSystem(),
                      id = generateID()) {
  # Children tags are non named tags passed as extra arguments
  number_children <- ifelse(
    is.null(names(list(...))),
    length(list(...)),
    length(list(...)[!names(list(...)) %>% sapply(. %>% {. != ""})])
  )

  attributes <- list(
    direction = direction,
    wrap = wrap,
    justify_content = justify_content,
    align_items = align_items,
    align_content = align_content,
    gap = gap,
    flex = flex,
    grow = grow,
    shrink = shrink,
    basis = basis
  )

  attributes %<>%
    applyTemplate(template, formals(flexPanel), "flex") %>%
    normalizeAttributes()

  tags$div(
    id = id,
    class = paste(list(...)$class, id),
    ...,
    tags$style(
      stringCSSRule("flex_base", id = id),
      attributes %>%
        generateFlexCSS(id, number_children, breakpoint_system)
    )
  )
}

#' Create a flexbox based page
#'
#' @param ... Tag attributes (named arguments) and children (unnamed arguments).
#'   A named argument with an `NA` value is rendered as a boolean attributes.
#'   Named arguments can be used to provide additional values to the container
#'   of the grid.
#'
#'   For a full list of valid HTML attributes check visit
#'   \url{https://www.w3schools.com/tags/ref_attributes.asp}.
#'
#'   Children may include any combination of:
#'   * Other tags objects
#'   * [HTML()] strings
#'   * [htmlDependency()]s
#'   * Single-element atomic vectors
#' @param title The browser window title (defaults to the host URL of the page)
#' @param fill_page Flag to tell the page if it should adjust the page to
#'   adjust and fill the browser window size
#' @param dependency The set of web dependencies. This value can be a
#'   htmlDependency, for example the shiny bootstrap one (the default)
#'   or a tagList with diferent dependencies
#'
#' @note See
#'   \url{https://css-tricks.com/snippets/css/a-guide-to-flexbox/}
#'   for additional details on using css flexbox
#'
#' @family flex functions
#' @seealso [flexPanel()]
#'
#' @examples
#' if (interactive()) {
#' library(shiny)
#' library(imola)
#' ui <- flexPage(
#'   title = "A flex page",
#'   div(class = "area-1", "Area 1 content"),
#'   div(class = "area-2", "Area 2 content"),
#'   div(class = "area-3", "Area 3 content")
#' )
#'
#' server <- function(input, output) {}
#' shinyApp(ui, server)
#' }
#' @importFrom shiny tagList tags bootstrapLib
#' @importFrom magrittr "%>%"
#'
#' @return A UI definition that can be passed to the [shinyUI] function.
#' @keywords flex page
#' @export
flexPage <- function(...,
                     title = NULL,
                     fill_page = TRUE,
                     dependency = bootstrapLib()) {
  tagList(
    if (fill_page) {
      tags$head(tags$style(getOption("imola.settings")$css$flexbox$fill_page))
    },
    if (!is.null(title)) {
      tags$head(tags$title(title))
    },
    dependency,
    flexPanel(..., id = "grid-page-wrapper")
  )
}
