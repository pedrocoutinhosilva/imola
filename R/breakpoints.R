#' Sets the current active media breakpoints. By default the default_system
#'   setting values are used, but the list can be customized by using the
#'   registerBreakpoint() and unregisterBreakpoint() functions.
#'
#' @param system The name of the media breakpoints system to use. Existing
#'   systems can be found under getOption("imola.breakpoints")
#'
#' @return A named list of media breakpoints options.
#' @export
setBreakpointSystem <- function(system) {
  options(imola.mediarules = getOption("imola.breakpoints")[[system]])
}

#' Current active media breakpoints. By default the default_system
#'   setting values are used, but the list can be customized by using the
#'   registerBreakpoint() and unregisterBreakpoint() functions.
#'
#' @return A named list of media breakpoints options.
#' @export
activeBreakpoints <- function() {
  getOption("imola.mediarules")
}

#' Adds a new breakpoint entry to the currelty active media breakpoints.
#'
#' @param name The name of the entry to remove
#' @param min The minimum screen width (in pixels) when the rule is active
#' @param max The maximum screen width (in pixels) when the rule is active
#'
#' @return No return value, called for side effects
#' @export
registerBreakpoint <- function(name, min = NULL, max = NULL) {
  rules <- getOption("imola.mediarules")
  rules[[name]] <- list(min = min, max = max)

  options(imola.mediarules = rules)
}

#' Allows removing an entry from the current activeBreakpoints.
#'
#' @param name The name of the entry to remove
#'
#' @return No return value, called for side effects
#' @export
unregisterBreakpoint <- function(name) {
  rules <- getOption("imola.mediarules")
  rules[[name]] <- NULL

  options(imola.mediarules = rules)
}
