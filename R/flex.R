#' Create a css flexbox based HTML tag
#'
#' @description
#' Creates a HTML tag and automatically generates css style rules based on css
#' flexbox, depending on the given arguments. Functionality acts as a way to
#' generate css flexbox based HTML containers directly from R without the need
#' to write any additional css rules directly.
#'
#' @param ... Tag attributes (named arguments) and child elements (unnamed
#'   arguments).
#'
#'   Named arguments are treated as additional html attribute
#'   values to the parent tag.
#'
#'   Child elements may include any combination of other tags objects, [HTML]
#'   strings, and [htmlDependency]s.
#' @param template The name of a registered template to use as a base for the
#'   grid, or a template object from [gridTemplate].
#' @param direction Direction of the flow of elements in the panel.
#'
#'   Accepts a valid css `flex-direction` value (`row` | `row-reverse` |
#'    `column` | `column-reverse`).
#'
#'   Default value of `row` value is used. Supports breakpoints.
#' @param wrap Should elements be allowed to wrap into multiple lines.
#'
#'   Accepts a valid css `flex-wrap` value (`nowrap` | `wrap` | `wrap-reverse`).
#'
#'   Supports breakpoints.
#' @param justify_content The alignment along the main axis. Accepts a
#'   valid css `justify-content` value (`flex-start` | `flex-end` | `center` |
#'   `space-between` | `space-around` | `space-evenly` | `start` |
#'    `end` | `left` | `right`).
#'
#'   Supports breakpoints.
#' @param align_items Defines the default behavior for how flex items are laid
#'   out along the cross axis on the current line.
#'
#'   Accepts a valid css `align-items` value (`stretch` | `flex-start` |
#'    `flex-end` | `center` | `baseline` | `first baseline` | `last baseline` |
#'    `start` | `end` | `self-start` | `self-end`).
#'
#'   Supports breakpoints.
#' @param align_content Aligns a flex container’s lines within when there is
#'   extra space in the cross-axis.
#'
#'   Accepts a valid css `align-content` value
#'   (flex-start | flex-end | center | space-between | space-around |
#'   space-evenly | stretch | start | end | baseline | first baseline |
#'   last baseline).
#'
#'   Supports breakpoints.
#' @param gap The space between elements in the panel. Controls both the
#'   space between rows and columns.
#'
#'   Accepts a css valid value, or 2 values separated by a space (if using
#'   diferent values for row and column spacing).
#'
#'   Supports breakpoints.
#' @param flex A vector of valid css 'flex' values.
#'   Defines how child elements in the panel can grow, shrink and their
#'   initial size.
#'
#'   Arguments that target child elements require a vector of
#'   values instead of a single value, with each entry of the vector affecting
#'   the nth child element.
#'
#'   If the vector has less entries that the total number
#'   of child elements, the values will be repeated until the pattern affects
#'   all elements in the panel. If the vector as more entries that the
#'   number of child elements, exceeding entries will be ignored. NA can also be
#'   used as a entry to skip adding a rule to a specific child element.
#'
#'   Accepts a valid css `flex` value vector of values.
#'
#'   By default c(1) is used, meaning all elements can grow and shrink as
#'   required, at the same rate. Supports breakpoints.
#' @param grow A vector of valid css 'flex-grow' values. Defines the rate of
#'   how elements can grow.
#'
#'   Entries will overwrite the 'flex' values, and can
#'   be used make more targeted rules.
#'
#'   Arguments that target child elements require a vector of
#'   values instead of a single value, with each entry of the vector affecting
#'   the nth child element.
#'
#'   If the vector has less entries that the total number
#'   of child elements, the values will be repeated until the pattern affects
#'   all elements in the panel. If the vector as more entries that the
#'   number of child elements, exceeding entries will be ignored. NA can also be
#'   used as a entry to skip adding a rule to a specific child element.
#'
#'   By default NULL is used, meaning values from the flex argument will be
#'   used instead. Supports breakpoints.
#' @param shrink A vector of valid css 'flex-shrink' values. Defines the rate
#'   of how elements can shrink. Entries will overwrite the nth 'flex' value,
#'   and can be used make more targeted rules.
#'
#'   Arguments that target child elements require a vector of
#'   values instead of a single value, with each entry of the vector affecting
#'   the nth child element.
#'
#'   If the vector has less entries that the total number
#'   of child elements, the values will be repeated until the pattern affects
#'   all elements in the panel. If the vector as more entries that the
#'   number of child elements, exceeding entries will be ignored. NA can also be
#'   used as a entry to skip adding a rule to a specific child element.
#'
#'   By default NULL is used, meaning values from the flex argument will be
#'   used instead. Supports breakpoints.
#' @param basis  A vector of valid css 'flex-basis' values. Defines the base
#'   size of elements. Entries will overwrite the nth 'flex' value,
#'   and can be used make more targeted rules.
#'
#'   Arguments that target child elements require a vector of
#'   values instead of a single value, with each entry of the vector affecting
#'   the nth child element.
#'
#'   If the vector has less entries that the total number
#'   of child elements, the values will be repeated until the pattern affects
#'   all elements in the panel. If the vector as more entries that the
#'   number of child elements, exceeding entries will be ignored. NA can also be
#'   used as a entry to skip adding a rule to a specific child element.
#'
#'   By default NULL is used, meaning values from the flex argument will be
#'   used instead. Supports breakpoints.
#' @param breakpoint_system Breakpoint system to use.
#' @param id The parent element id.
#'
#' @details Behaves similar to a normal HTML tag, but provides helping
#'   arguments that simplify the way flexbox css can be created from shiny.
#'
#' @note When creating responsive layouts based on css media rules, some
#'   arguments allow a named list can be passed instead of a single value.
#'
#'   The names in that list can be any of the breakpoints available in
#'   the `breakpoint_system` argument.
#'
#'   It is recommended to define the breakpoint system for the application
#'   globally before UI definitions, but the `breakpoint_system` in panel
#'   functions allows for more flexibility when reusing components
#'   from other projects.
#'
#'   See \url{https://css-tricks.com/snippets/css/a-guide-to-flexbox/}
#'   for additional details on using css flexbox.
#'
#'   For a full list of valid HTML attributes check visit
#'   \url{https://www.w3schools.com/tags/ref_attributes.asp}.
#'
#' @family flexbox
#' @seealso [flexPage]
#'
#' @importFrom magrittr "%>%" "%<>%"
#' @importFrom htmltools HTML
#'
#' @return An HTML [tagList].
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

#' Create a css flexbox based page
#'
#' @description
#' Create a Shiny UI page using a [flexPanel] to wrap the page content.
#' As other Shiny UI pages, it scaffolds the entire page and loads any required
#' or registered dependencies.
#'
#' @param ... Arguments to be passed to [flexPanel].
#' @param title The browser window title (defaults to the host URL of the page).
#' @param fill_page Boolean value if the page should automatically stretch to
#'   match the browser window height.
#' @param dependency A set of web dependencies. This value can be a
#'   [htmlDependency], for example the shiny bootstrap dependency (default
#'   value) or a [tagList] with diferent dependencies.
#'
#' @note See
#'   \url{https://css-tricks.com/snippets/css/a-guide-to-flexbox/}
#'   for additional details on using css flexbox.
#'
#' @family flex
#' @seealso [flexPanel]
#'
#' @importFrom shiny tagList tags bootstrapLib
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
