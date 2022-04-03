#' List registered breakpoint systems
#'
#' @description
#' Lists all available breakpoint systems.
#'
#' @return A named list of css templates and specific values.
#' @keywords breakpoints breakpoint_system
#' @export
listBreakpointSystems <- function() {
  getOption("imola.breakpoint.systems")
}

#' Create a breakpoint system
#'
#' @description
#' Creates a breakpoint system object containing all
#' the information about the system, including its name and set of
#' available breakpoints.
#'
#' @param name A string with the name that identifies the breakpoint system.
#' @param ... One or more breakpoint objects created with [breakpoint].
#' @param description Optional description with information.
#'   about the breakpoint system. Can be used to pass on any information
#'   regarding the system (For example its origin or connected frameworks).
#'
#' @importFrom magrittr "%>%"
#'
#' @return A breakpoint system object.
#' @keywords breakpoints breakpoint_system
#' @export
breakpointSystem <- function(name, ..., description = NULL) {
  stopifnot(
    "All ... arguments must be valid breakpoints()" = {
      list(...) %>%
        lapply(is.breakpoint) %>%
        unlist() %>%
        all()
    },

    "At least one breakpoint must be provided" = {
      length(list(...)) > 0
    }
  )

  breakpoints <- list()
  for (single in list(...)) {
    breakpoints[[single$name]] <- single
  }

  list(
    name = name,
    description = description,
    breakpoints = breakpoints
  ) %>%
  addClass("imola.breakpoint.system")
}

#' Register a breakpoint system
#'
#' @description
#' Registers a breakpoint system object to make it available globally in
#' `getOption("imola.breakpoint.systems")`. After registered it can be retrieved
#' anywhere using [getBreakpointSystem].
#'
#' @param system A breakpoint system object created with [breakpointSystem].
#'
#' @return No return value, called for side effects.
#' @keywords breakpoints breakpoint_system
#' @export
registerBreakpointSystem <- function(system) {
  stopifnot(
    "Given system is not a valid breakpointSystem()" = {
      is.breakpointSystem(system)
    }
  )

  registered_systems <- getOption("imola.breakpoint.systems")
  registered_systems[[system$name]] <- system

  message("Breakpoint system ", system$name, " has been registered.")
  options(imola.breakpoint.systems = registered_systems)
}

#' Unregister a breakpoint system
#'
#' @description
#' Removes a globally registered breakpoint system from
#' `getOption("imola.breakpoint.systems")`.
#'
#' @param name A string with the name of a registered breakpoint system.
#'   Registered systems are available
#'   in `getOption("imola.breakpoint.systems")`.
#'
#' @return No return value, called for side effects.
#' @keywords breakpoints breakpoint_system
#' @export
unregisterBreakpointSystem <- function(name) {
  stopifnot(
    "No Breakpoint system registered with that name" = {
      !(is.null(getOption("imola.breakpoint.systems")[[name]]))
    }
  )

  registered_systems <- getOption("imola.breakpoint.systems")
  registered_systems[[name]] <- NULL

  options(imola.breakpoint.systems = registered_systems)
}

#' Import a breakpoint system
#'
#' @description
#' Imports a breakpoint system from a file.
#' Breakpoint systems can be exported into a file format using
#' [exportBreakpointSystem].
#'
#' @param path The file path of the file to import, including the file
#'   name and extension. The file name must end with a `.yaml` extension.
#'
#' @importFrom yaml read_yaml
#'
#' @return A breakpoint system object.
#' @keywords breakpoints breakpoint_system
#' @export
importBreakpointSystem <- function(path) {
  options <- read_yaml(path)

  stopifnot(
    "Wrong file format" = {
      !(is.null(options$name))
    },

    "No breakpoint information" = {
      !(is.null(options$breakpoints))
    }
  )

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

#' Export a breakpoint system
#'
#' @description
#' Exports a breakpoint system into a file for storage and later usage.
#' Exported systems can be retrieved from their file form by using
#' [importBreakpointSystem].
#'
#' @param system A string with the name of a registered breakpoint system, or a
#'   breakpoint system object generated with [breakpointSystem].
#' @param path The file path where to export the system to, including the file
#'   name and extension. The file name must end with a `.yaml` extension.
#'
#' @importFrom yaml write_yaml
#'
#' @return No return value, called for side effects.
#' @keywords breakpoints breakpoint_system
#' @export
exportBreakpointSystem <- function(system, path) {
  if (is.character(system)) {
    output <- getOption("imola.breakpoint.systems")[[system]]
  }

  if (is.breakpointSystem(system)) {
    output <- system
  }

  stopifnot(
    "No valid breakpoint system to export" = {
      !(is.null(output))
    }
  )

  message("Exported ", output$name, " breakpoint system to ", path, ".")
  write_yaml(output, path)
}

#' Set the active breakpoint system
#'
#' @description
#' Sets the current globally active breakpoint system. The active breakpoint
#' system is used for grid function as the default system if no system is
#' provided as an argument.
#'
#' @param system A string with the name of a registered breakpoint system, or a
#'   breakpoint system object generated with [breakpointSystem]. If a breakpoint
#'   system object is used, it will be registered as well.
#'
#' @return A breakpoint system object.
#' @keywords breakpoints breakpoint_system
#' @export
setActiveBreakpointSystem <- function(system) {
  if (is.character(system)) {
    output <- getOption("imola.breakpoint.systems")[[system]]
  }

  if (is.breakpointSystem(system)) {
    output <- system
    registerBreakpointSystem(system)
  }

  stopifnot(
    "No valid breakpoint system to make active" = {
      !(is.null(output))
    }
  )

  options(imola.mediarules = output)

  system
}

#' Get a registered breakpoint system
#'
#' @description
#' Returns a breakpoint system object of a registered breakpoint system by
#' its name or, the currently active breakpoint system if no system name is
#' provided.
#'
#' @param name A string with the name of a registered breakpoint system, or
#'   `NULL` if looking for the currently active breakpoint system.
#'
#' @return A breakpoint system object.
#' @keywords breakpoints breakpoint_system
#' @export
getBreakpointSystem <- function(name = NULL) {
  if (is.null(name)) {
    return(getOption("imola.mediarules"))
  }

  stopifnot(
    "No registered breakpoint system by that name" = {
      !(is.null(getOption("imola.breakpoint.systems")[[name]]))
    }
  )

  return(getOption("imola.breakpoint.systems")[[name]])
}
