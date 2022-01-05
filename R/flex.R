#' Create a panel with a CSS flexbox layout
#'
#' @param ... Elements to include within the panel
#' @param template The name of the template to use as a base for the grid.
#'   See listTemplates() and registerTemplate() for more information.
#' @param direction Direction of the flow of elements in the panel. Accepts a
#'   valid css 'flex-direction' value (row | row-reverse | column |
#'   column-reverse) By default the 'row' value is used.
#'   Supports named list for breakpoints.
#' @param wrap Should elements be allowed to wrap into multiple lines. Accepts
#'   a valid css 'flex-wrap' value (nowrap | wrap | wrap-reverse). By default
#'   the value 'wrap' is used.
#'   Supports named list for breakpoints.
#' @param justify_content Defines the alignment along the main axis. Accepts a
#'   valid css 'justify-content' value (flex-start | flex-end | center |
#'   space-between | space-around | space-evenly | start | end | left | right).
#'   By default the value 'flex-start' is used.
#'   Supports named list for breakpoints.
#' @param align_items Defines the default behavior for how flex items are laid
#'   out along the cross axis on the current line. Accepts a valid css
#'   'align-items' value (stretch | flex-start | flex-end | center | baseline |
#'   first baseline | last baseline | start | end | self-start | self-end).
#'   By default the value 'stretch' is used.
#'   Supports named list for breakpoints.
#' @param align_content Aligns a flex container’s lines within when there is
#'   extra space in the cross-axis. Accepts a valid css align-content' value
#'   (flex-start | flex-end | center | space-between | space-around |
#'   space-evenly | stretch | start | end | baseline | first baseline |
#'   last baseline). By default the value 'flex-start' is used.
#'   Supports named list for breakpoints.
#' @param gap Defines the space between elements in the panel. Defaults to 0.
#'   Supports named list for breakpoints.
#' @param flex A vector of valid css 'flex' values. Defines how elements in the
#'   panel can grow and shrink. Each entry of the vector will afect the nth
#'   child of the panel, meaning that it can be at maximum the lenght of the
#'   elements in the panel. If smaller the vector will be repeated until the
#'   pattern affects all elements in the panel. NA can also be used as a entry
#'   of the vector to skip adding a rule to specific elements. By default c(1)
#'   is used, meaning all elements can grow and shrink as required, at the same
#'   rate. See notes for more information.
#'   Supports named list for breakpoints.
#' @param grow A vector of valid css 'flex-grow' values. Defines the rate of
#'   how elements can grow. Entries will overwrite the 'flex' values, and can
#'   be used make more targeted rules. Each entry of the vector will afect the
#'   nth child of the panel, meaning that it can be at maximum the lenght of
#'   the elements in the panel. If smaller the vector will be repeated until
#'   the pattern affects all elements in the panel. NA can also be used as a
#'   entry of the vector to skip adding a rule to specific elements. By default
#'   c() is used, meaning values from the flex argument will be used. See notes
#'   for more information.
#'   Supports named list for breakpoints.
#' @param shrink A vector of valid css 'flex-shrink' values. Defines the rate
#'   of how elements can shrink. Entries will overwrite the 'flex' values, and
#'   can be used make more targeted rules. Each entry of the vector will afect
#'   the nth child of the panel, meaning that it can be at maximum the lenght
#'   of the elements in the panel. If smaller the vector will be repeated until
#'   the pattern affects all elements in the panel. NA can also be used as a
#'   entry of the vector to skip adding a rule to specific elements. By default
#'   c() is used, meaning values from the flex argument will be used. See notes
#'   for more information.
#'   Supports named list for breakpoints.
#' @param basis  A vector of valid css 'flex-basis' values. Defines the base
#'   size of elements. Entries will overwrite the 'flex' values, and can be
#'   used make more targeted rules. Each entry of the vector will afect the nth
#'   child of the panel, meaning that it can be at maximum the lenght of the
#'   elements in the panel. If smaller the vector will be repeated until the
#'   pattern affects all elements in the panel. NA can also be used as a entry
#'   of the vector to skip adding a rule to specific elements. By default c()
#'   is used, meaning values from the flex argument will be used. See notes for
#'   more information.
#'   Supports named list for breakpoints.
#' @param breakpoint_system Optional Media breakpoints to use. Will default to
#'   the current active breakpoint system.
#' @param id The panel id. A randomly generated one is used by default.
#'
#' @details Behaves similar to normal HTML div tags, but simplifies
#'   the way css flexbox can be used from shiny.
#'
#' @note When creating responsive layouts based on media rules, for most
#'   arguments a named list can be passed instead of a single value. The names
#'   in the list can be any of the registered breakpoints available in
#'   activeBreakpoints(). Breakpoints can also be modified with the
#'   registerBreakpoint() and unregisterBreakpoint() functions. Arguments that
#'   allow this are: direction | wrap | justify_content | align_items |
#'   align_content | gap | flex | grow | shrink | basis.
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
                      breakpoint_system = activeBreakpoints(),
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

#' Create a page a with CSS flexbox layout
#'
#' @param ... Elements to include within the page
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
#' library(imola)
#' flexPage(
#'   title = "A flex page",
#'   div(class = "area-1"),
#'   div(class = "area-2"),
#'   div(class = "area-3")
#' )
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
