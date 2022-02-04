#' Create a css grid based HTML tag
#'
#' @description
#' Creates a HTML tag and automatically generates css style rules based on css
#' grid, depending on the given arguments. Functionality acts as a way to
#' generate css grid based HTML containers directly from R without the need
#' to write any additional css rules directly.
#'
#' @param ... Tag attributes (named arguments) and child elements (unnamed
#'   arguments or with names used in areas).
#'
#'   Named arguments are treated as additional html attribute
#'   values to the parent tag, unless that name is used in the areas attribute
#'   as a grid area name.
#'
#'   Child elements may include any combination of other tags objects, [HTML]
#'   strings, and [htmlDependency]s.
#' @param template The name of a registered template to use as a base for the
#'   grid, or a template object from [gridTemplate].
#' @param areas A list of vectors with area names, or a vector or strings
#'   representing each row of the grid. Each element should contain
#'   the names, per row, of each area of the grid.
#'
#'   Expected values follow the
#'   convension for the `grid-template-areas` css attribute.
#'
#'   for example `c("area-1 area-1", "area-2 area-3")` and
#'   `list(c("area-1", "area-1"), c(area-2", "area-3"))` are both valid
#'   representations of a 2x2 grid with 3 named areas.
#'
#'   Supports breakpoints.
#' @param rows A string of css valid sizes separated by a space. or a vector of
#'   sizes. For example both `"1fr 2fr"` or `c("1fr", "2fr")` are valid
#'   representations of the same 2 rows grid sizes.
#'
#'   Follows the convension for the `grid-template-rows` css attribute.
#'
#'   If not provided the existing space will be split equally acording to the
#'   areas defined in areas.
#'
#'   Supports breakpoints.
#' @param columns A string of css valid sizes separated by a space. or a vector
#'   of sizes. For example both `"1fr 2fr"` or `c("1fr", "2fr") `are valid
#'   representations of the same 2 columns grid sizes.
#'
#'   Follows the convension for the `grid-template-columns` css attribute.
#'
#'   If not provided the existing space will be split equally acording to the
#'   areas defined in areas.
#'
#'   Supports breakpoints.
#' @param gap The space between elements in the panel. Controls both the
#'   space between rows and columns.
#'
#'   Accepts a css valid value, or 2 values separated by a space (if using
#'   diferent values for row and column spacing).
#'
#'   Supports breakpoints.
#' @param align_items The cell behavior according to the `align-items` css
#'   property. Aligns grid items along the block (column) axis.
#'
#'   Accepts a valid css `align-items` value
#'   (`start` | `end` | `center` | `stretch`).
#'
#'   Supports breakpoints.
#' @param justify_items The cell behavior according to the `justify-items` css
#'   property. Aligns grid items along the inline (row) axis.
#'
#'   Accepts a valid css `justify-items` value
#'   (`start` | `end` | `center` | `stretch`).
#'
#'   Supports breakpoints.
#' @param auto_fill Should the panel stretch to fit its parent size (TRUE), or
#'    should its size be based on its children element sizes (FALSE).
#'
#'   Supports breakpoints.
#' @param breakpoint_system Breakpoint system to use.
#' @param id The parent element id.
#'
#' @details Behaves similar to a normal HTML tag, but provides helping
#'   arguments that simplify the way grid css can be created from shiny.
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
#'   See \url{https://css-tricks.com/snippets/css/complete-guide-grid/}
#'   for additional details on using css grids.
#'
#'   For a full list of valid HTML attributes check visit
#'   \url{https://www.w3schools.com/tags/ref_attributes.asp}.
#'
#' @family grid
#' @seealso [gridPage]
#'
#' @importFrom magrittr "%>%"
#' @importFrom shiny tagAppendAttributes tagAppendChild
#'
#' @return An HTML [tagList].
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

#' Create a css grid based page
#'
#' @description
#' Create a Shiny UI page using a [gridPanel] to wrap the page content.
#' As other Shiny UI pages, it scaffolds the entire page and loads any required
#' or registered dependencies.
#'
#' @param ... Arguments to be passed to [gridPanel].
#' @param title The browser window title (defaults to the host URL of the page).
#' @param fill_page Boolean value if the page should automatically stretch to
#'   match the browser window height.
#' @param dependency A set of web dependencies. This value can be a
#'   [htmlDependency], for example the shiny bootstrap dependency (default
#'   value) or a [tagList] with diferent dependencies.
#'
#' @note See
#'   \url{https://css-tricks.com/snippets/css/complete-guide-grid/}
#'   for additional details on using css grids.
#'
#' @family grid functions
#' @seealso [gridPanel]
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
