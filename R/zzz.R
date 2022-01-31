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
  options(imola.breakpoints = breakpoint_systems)



  # Default mediarules breakpoints (Based on bootstrap rules)
  default_system <- getOption("imola.settings")$default_system
  options(imola.mediarules = getOption("imola.breakpoints")[[default_system]])



  grid_templates <- list()
  for (file in list.files(system.file("templates/grid/", package = "imola"))) {
    grid_templates[[sub("\\.yaml$", "", file)]] <- file %>%
      paste0("templates/grid/", .) %>%
      system.file(package = "imola") %>%
      yaml::read_yaml()
  }

  flex_templates <- list()
  for (file in list.files(system.file("templates/flex/", package = "imola"))) {
    flex_templates[[sub("\\.yaml$", "", file)]] <- file %>%
      paste0("templates/flex/", .) %>%
      system.file(package = "imola") %>%
      yaml::read_yaml()
  }

  # Default templates
  options(imola.templates = list(
    grid = grid_templates,
    flex = flex_templates
  ))
}
