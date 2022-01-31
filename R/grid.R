#' Create a panel with a CSS grid layout
#'
#' @param ... Elements to include within the panel. If areas are used, named
#'   named arguments using the grid area name will be added to that grid area.
#'   If no named arguments or areas are used, non attribute elements will be
#'   added to existing grid cells based on their order.
#' @param template The name of the template to use as a base for the grid, or
#'   the resulting value from using makeTemplate() to generate a template
#'   object. See listTemplates() and registerTemplate() for more information.
#' @param areas A list of vectors with area names, or a vector or strings
#'   representing each row of the grid. Each element should contain
#'   the names, per row, of each area of the grid. Expected values follow the
#'   convension for the grid-template-areas css attribute.
#'   for example c("area-1 area-1", "area-2 area-3") and
#'   list(c("area-1", "area-1"), c(area-2", "area-3")) are both valid
#'   representations of a 2x2 grid with 3 named areas.
#'   If using breakpoints, a named list of valid values where each name is a
#'   valid breakpoint can be used as well.
#'   For example list( default = c("area-1", "area-2"),
#'   xs = list(c("area-1"), c("area-2"))) would be a valid value
#'   for breakpoints
#' @param rows A string of css valid sizes separated by a space. or a vector of
#'   sizes. For example both "1fr 2fr" or c("1fr", "2fr") are valid
#'   representations of the same 2 rows grid sizes.
#'   Follows the convension for the grid-template-rows css attribute.
#'   If not provided the existing space will be split equally acording to the
#'   areas defined in areas.
#'   Supports named list for breakpoints.
#' @param columns A string of css valid sizes separated by a space. or a vector
#'   of sizes. For example both "1fr 2fr" or c("1fr", "2fr") are valid
#'   representations of the same 2 columns grid sizes.
#'   Follows the convension for the grid-template-columns css attribute.
#'   If not provided the existing space will be split equally acording to the
#'   areas defined in areas.
#'   Supports named list for breakpoints.
#' @param gap The space (in a valid css size) between each grid cell.
#'   Supports named list for breakpoints.
#' @param align_items The cell behavior according to the align-items css
#'   property. Aligns grid items along the block (column) axis.
#'
#'   Accepts a valid css `align-items` value
#'   (`start` | `end` | `center` | `stretch`)
#'
#'   By default the `stretch` value is used. Supports breakpoints.
#' @param justify_items The cell behavior according to the justify-items css
#'   property. Aligns grid items along the inline (row) axis.
#'
#'   Accepts a valid css `justify-items` value
#'   (`start` | `end` | `center` | `stretch`)
#'
#'   By default the `stretch` value is used. Supports breakpoints.
#' @param auto_fill Should the panel stretch to fit its parent size (TRUE), or
#'    should its size be based on its children element sizes (FALSE).
#'   Supports named list for breakpoints.
#' @param breakpoint_system Optional Media breakpoints to use. Will default to
#'   the current active breakpoint system.
#' @param id The html id of the panel container.
#'
#' @details Behaves similar to normal HTML div tags, but simplifies
#'   the way css grid can be used via the arguments area, rows and columns.
#'   Only areas is required, when not used rows and columns will simply split
#'   the existing space equaly between each row / column.
#'   Internally the function creates the styles for the grid positions by
#'   generating the rules for positioning the children via their classes.
#'   To position a child element simply make sure that it includes a class
#'   with the same name as the named area.
#'
#' @note When creating responsive layouts based on media rules, for arguments
#'   a named list can be passed instead of a single value. The names in the list
#'   can be any of the registered breakpoints available in getBreakpointSystem().
#'   Breakpoints can also be modified with the registerBreakpoint() and
#'   unregisterBreakpoint() functions. Arguments that allow this are: areas |
#'   rows | columns | gap.
#'
#' @note See \url{https://css-tricks.com/snippets/css/complete-guide-grid/}
#'   for additional details on using css grids
#'
#' @family grid functions
#' @seealso [gridPage()]
#'
#' @examples
#' if (interactive()) {
#' library(imola)
#' gridPanel(
#'   areas = c("area-1 area-1", "area-2 area-3"),
#'   rows = "1fr 2fr",
#'   columns = "2fr 100px",
#'   div(class = "area-1"),
#'   div(class = "area-2"),
#'   div(class = "area-3")
#' )
#' }
#'
#' @importFrom magrittr "%>%"
#' @importFrom shiny tagAppendAttributes tagAppendChild
#'
#' @return An HTML tagList.
#' @keywords grid panel
#' @export
gridPanel <- function(...,
                      template = NULL,
                      areas = NULL,
                      rows = NULL,
                      columns = NULL,
                      gap = NULL,
                      align_items = "stretch",
                      justify_items = "stretch",
                      auto_fill = TRUE,
                      breakpoint_system = getBreakpointSystem(),
                      id = generateID()) {
  attributes <- list(
    areas = areas,
    rows = rows,
    columns = columns,
    gap = gap,
    align_items = align_items,
    justify_items = justify_items
  )

  attributes %<>%
    applyTemplate(template, formals(gridPanel), "grid") %>%
    normalizeAttributes()

  unique_areas <- attributes$areas %>%
    unlist() %>%
    unique()

  do.call(
    tags$div,
    list(...) %>% processContent(unique_areas)
  ) %>%
  tagAppendAttributes(id = id) %>%
  tagAppendAttributes(class = paste(list(...)$class, id)) %>%
  tagAppendChild(tags$style(
    stringCSSRule("grid_base", id = id),
    if (auto_fill) {
      stringCSSRule("grid_auto_fill", id = id)
    },
    attributes %>%
      generateGridCSS(id, unique_areas, breakpoint_system)
  ))
}

#' Create a page a with CSS grid layout
#'
#' @param ... Elements to include within the page
#' @param title The browser window title (defaults to the host URL of the page).
#' @param fill_page Flag to tell the page if it should adjust the page to
#'   adjust and fill the browser window size.
#' @param dependency The set of web dependencies. This value can be a
#'   htmlDependency, for example the shiny bootstrap one (the default)
#'   or a tagList with diferent dependencies
#'
#' @note See
#'   \url{https://css-tricks.com/snippets/css/complete-guide-grid/}
#'   for additional details on using css grids
#'
#' @family grid functions
#' @seealso [gridPanel()]
#'
#' @examples
#' if (interactive()) {
#' library(imola)
#' gridPage(
#'   title = "A grid page",
#'   areas = c("area-1 area-1", "area-2 area-3"),
#'   div(class = "area-1"),
#'   div(class = "area-2"),
#'   div(class = "area-3")
#' )
#' }
#'
#' @importFrom shiny tagList tags bootstrapLib
#' @importFrom magrittr "%>%"
#'
#' @return A UI definition that can be passed to the [shinyUI] function.
#' @keywords grid page
#' @export
gridPage <- function(...,
                     title = NULL,
                     fill_page = TRUE,
                     dependency = bootstrapLib()) {
  tagList(
    if (fill_page) {
      tags$head(tags$style(getOption("imola.settings")$css$grid$fill_page))
    },
    if (!is.null(title)) {
      tags$head(tags$title(title))
    },
    dependency,
    gridPanel(..., id = "grid-page-wrapper")
  )
}
