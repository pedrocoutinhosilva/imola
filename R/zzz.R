# quiets concerns of R CMD check re: the .'s that appear in pipelines
if (getRversion() >= "2.15.1")  utils::globalVariables(c("."))

.onLoad <- function(libname, pkgname) {
  # Mapping between R arguments and css attributes
  options(imola.settings = readSettingsFile("config"))

  # Full list of default mediarules breakpoint systems
  breakpoint_files <- list.files(
    system.file("breakpoints/", package = "imola"),
    pattern = "\\.yaml$"
  )
  breakpoint_systems <- list()
  for (file_name in breakpoint_files) {
    system <- importBreakpointSystem(
      paste0(system.file("breakpoints", package = "imola"), "/", file_name)
    )

    breakpoint_systems[[system$name]] <- system
  }
  options(imola.breakpoint.systems = breakpoint_systems)



  # Default mediarules breakpoints (Based on bootstrap rules)
  default_system <- getOption("imola.settings")$default_system
  options(
    imola.mediarules = getOption("imola.breakpoint.systems")[[default_system]]
  )

  grid_templates <- list()
  grid_templates_files <- list.files(
    system.file("templates/grid/", package = "imola"),
    pattern = "\\.yaml$"
  )
  for (file_name in grid_templates_files) {
    grid_templates[[sub("\\.yaml$", "", file_name)]] <- importTemplate(
      paste0(system.file("templates/grid/", package = "imola"), "/", file_name)
    )
  }

  flex_templates <- list()
  flex_templates_files <- list.files(
    system.file("templates/flex/", package = "imola"),
    pattern = "\\.yaml$"
  )
  for (file_name in flex_templates_files) {
    flex_templates[[sub("\\.yaml$", "", file_name)]] <- importTemplate(
      paste0(system.file("templates/flex/", package = "imola"), "/", file_name)
    )
  }

  # Default templates
  options(imola.templates = list(
    grid = grid_templates,
    flex = flex_templates
  ))
}
