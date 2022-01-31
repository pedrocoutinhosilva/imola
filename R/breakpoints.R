#' Generated a valid breakpoint to use in a breakpoint system. While both the
#'   min and max arguments are optional, at least one of them must exist for
#'   the breakpoint to be considered valid.
#'
#' @param name The name of the breakpoint.
#' @param min Optional numeric minimum value (in pixels) of the screen width
#'   where the breakpoint is valid.
#' @param max Optional numeric maximum value (in pixels) of the screen width
#'   where the breakpoint is valid.
#'
#' @return A breakpoint object.
#' @keywords breakpoints
#' @export
breakpoint <- function(name, min = NULL, max = NULL) {
  if (is.null(min) && is.null(max)) {
    stop("Arguments min and max cannot both be NULL.")
  }

  list(
    name = name,
    min = min,
    max = max
  ) %>% {
    class(.) %<>%
      append("imola.breakpoint")
    .
  }
}

#' Custom print function for a breakpoint object.
#'
#' @param x the object to print.
#' @param ... Additional arguments.
#'
#' @return No return value, called for side effects.
#' @keywords breakpoints
#' @export
print.imola.breakpoint <- function(x, ...) {
  cat("Imola Breakpoint\n")
  cat("Name: ", x$name, "\n")
  cat("\n")
  cat("Affect Screen Sizes:\n")
  cat("Minimum: ", ifelse(is.null(x$min), "Any size below minimum", paste(x$min, "px")), "\n")
  cat("Maximum: ", ifelse(is.null(x$max), "Any size above minimum", paste(x$max, "px")), "\n")
}

#' Generated a valid breakpoint system to use in grid functions.
#'
#' @param name The name of the breakpoint system.
#' @param ... Any number of breakpoint objects generated with breakpoint().
#' @param description Optional description with additional information
#'   regarding the breakpoint system.
#'
#' @return A breakpoint system object.
#' @keywords breakpoints
#' @export
breakpointSystem <- function(name, ..., description = NULL) {
  lapply(list(...), . %>% {
    if (!is(., "imola.breakpoint")) {
      stop("all ... arguments must be valid breakpoints()")
    }
  })

  breakpoints <- list()
  for (single in list(...)) {
    breakpoints[[single$name]] <- single
  }

  list(
    name = name,
    description = description,
    breakpoints = breakpoints
  ) %>% {
    class(.) %<>%
      append("imola.breakpoint.system")
    .
  }
}

#' Custom print function for a breakpoint system object.
#'
#' @param x the object to print.
#' @param ... Additional arguments.
#'
#' @return No return value, called for side effects.
#' @keywords breakpoints
#' @export
print.imola.breakpoint.system <- function(x, ...) {
  output <- do.call(
    rbind,
    lapply(
      lapply(names(x$breakpoints), . %>% {
        list(
          `Available Breakpoints (name)` = .,
           `Minimum screen size (px)` = x$breakpoints[[.]]$min,
           `Maximum screen size (px)` = x$breakpoints[[.]]$max
         )
      }),
      function(breakpoint) {
        as.data.frame(t(breakpoint), stringsAsFactors = FALSE)
      }
    )
  )

  cat("Imola Breakpoint System\n")
  cat("Name: ", x$name, "\n")
  cat("description: ", ifelse(!is.null(x$description), x$description, "No description"), "\n")
  print(knitr::kable(output, "simple"))
  cat("-----------------------------\n")
}

#' Adds a breakpoint to a breakpoint system object.
#'
#' @param system A breakpoint system object generated with breakpointSystem().
#' @param breakpoint A valid breakpoint generated with breakpoint().
#'
#' @return A breakpoint system object.
#' @keywords breakpoints
#' @export
addBreakpoint <- function(system, breakpoint) {
  if (!is(breakpoint, "imola.breakpoint")) {
    stop("breakpoint is not a valid breakpoint()")
  }

  if (!is(system, "imola.breakpoint.system")) {
    stop("system is not a valid breakpointSystem()")
  }

  system$breakpoints[[breakpoint$name]] <- breakpoint

  system
}

#' Removes a breakpoint from a breakpoint system object by name.
#'
#' @param system A breakpoint system object generated with breakpointSystem().
#' @param breakpoint The name of a breakpoint in the given system.
#'
#' @return A breakpoint system object.
#' @keywords breakpoints
#' @export
removeBreakpoint <- function(system, breakpoint) {
  if (!is(system, "imola.breakpoint.system")) {
    stop("system is not a valid breakpointSystem()")
  }

  system$breakpoints[[breakpoint]] <- NULL

  system
}

#' Registers a breakpoint system object to make it available globally in
#'   getOption("imola.breakpoints"). After registered it can be retrieved
#'   anywhere using getBreakpointSystem().
#'
#' @param system A breakpoint system object generated with breakpointSystem().
#'
#' @return No return value, called for side effects.
#' @keywords breakpoints
#' @export
registerBreakpointSystem <- function(system) {
  if (!is(system, "imola.breakpoint.system")) {
    stop("system is not a valid breakpointSystem()")
  }

  registered_systems <- getOption("imola.breakpoints")
  registered_systems[[system$name]] <- system

  message("Breakpoint system has been registered for global usage")
  options(imola.breakpoints = registered_systems)
}

#' Unregisters a globally registered breakpoint system in
#'   getOption("imola.breakpoints").
#'
#' @param system The name of a registered breakpoint system, available in
#'   getOption("imola.breakpoints").
#'
#' @return No return value, called for side effects.
#' @keywords breakpoints
#' @export
unregisterBreakpointSystem <- function(system) {
  if (is.null(getOption("imola.breakpoints")[[system]])) {
    warning("No Breakpoint system registered with that name")
    return()
  }

  registered_systems <- getOption("imola.breakpoints")
  registered_systems[[system]] <- NULL

  options(imola.breakpoints = registered_systems)
}

#' Imports a breakpoint system from a file.
#'   Breakpoint systems can be exported into a file format by using
#'   exportBreakpointSystem()
#'
#' @param path A file path of the file to import, including the file
#'   name and extension. The file name must end with a ".yaml" extension.
#'
#' @return A breakpoint system object.
#' @keywords breakpoints
#' @export
importBreakpointSystem <- function(path) {
  options <- yaml::read_yaml(path)

  if (is.null(options$name)) {
    stop("Wrong file format")
  }

  if (is.null(options$breakpoints)) {
    stop("No breakpoint information")
  }

  for (single in names(options$breakpoints)) {
    options$breakpoints[[single]] <- breakpoint(
      options$breakpoints[[single]]$name,
      min = options$breakpoints[[single]]$min,
      max = options$breakpoints[[single]]$max
    )
  }

  do.call(
    breakpointSystem,
    modifyList(
      list(
        name = options$name,
        description = options$description
      ),
      options$breakpoints
    )
  )
}

#' Exports a breakpoint system into a file for storage and later usage.
#'   Exported files can be retrieved from thier file form by using
#'   importBreakpointSystem()
#'
#' @param system The name of a registered breakpoint system, or a breakpoint
#'   system object generated with breakpointSystem().
#' @param path A file path where to export the system to including the file
#'   name and extension. The file name must end with a ".yaml" extension.
#'
#' @return No return value, called for side effects.
#' @keywords breakpoints
#' @export
exportBreakpointSystem <- function(system, path) {
  if (is.character(system)) {
    output <- getOption("imola.breakpoints")[[system]]
  }

  if (is(system, "imola.breakpoint.system")) {
    output <- system
  }

  if (is.null(output)) {
    stop("No valid breakpoint system to export")
  }

  message("Exported ", a$name, " breakpoint system to ", path, ".")
  yaml::write_yaml(output, path)
}

#' Sets the current globally active breakpoint system.
#'
#' @param system The name of a registered breakpoint system or a breakpoint
#'   system object generated with breakpointSystem().
#'
#' @return A breakpoint system object.
#' @keywords breakpoints
#' @export
setActiveBreakpointSystem <- function(system) {
  if (is.character(system)) {
    output <- getOption("imola.breakpoints")[[system]]
  }

  if (is(system, "imola.breakpoint.system")) {
    output <- system
    registerBreakpointSystem(system)
  }

  if (is.null(output)) {
    stop("No valid breakpoint system to export")
  }

  options(imola.mediarules = output)

  system
}

#' Returns a object form of a registered breakpoint system by its name or,
#'   the currently active breakpoint system if no system name is provided.
#'
#' @param system The name of a registered breakpoint system, or NULL if looking
#'   for the currently active breakpoint system
#'
#' @return A breakpoint system object.
#' @keywords breakpoints
#' @export
getBreakpointSystem <- function(system = NULL) {
  if (is.null(system)) {
    return(getOption("imola.mediarules"))
  }

  if (is.null(getOption("imola.breakpoints")[[system]])) {
    warning("No registered breakpoint system by that name")
    return()
  }

  return(getOption("imola.breakpoints")[[system]])
}
