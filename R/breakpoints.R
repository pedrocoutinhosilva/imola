#' Create a breakpoint
#'
#' @description
#' Creates a valid breakpoint object to use in a breakpoint system. While both
#' the min and max arguments are optional, at least one of them must exist for
#' the breakpoint to be considered valid.
#'
#' @param name A string with the name that identifies the breakpoint.
#' @param min Optional numeric minimum value (in pixels) of the screen width
#'   where the breakpoint is active.
#' @param max Optional numeric maximum value (in pixels) of the screen width
#'   where the breakpoint is active.
#'
#' @importFrom magrittr "%>%"
#'
#' @return A breakpoint object.
#' @keywords breakpoints breakpoint
#' @export
breakpoint <- function(name, min = NULL, max = NULL) {
  stopifnot(
    "Name should be a character string" = {
      is.character(name)
    },
    "Arguments min and max cannot both be NULL at the same time." = {
      !(is.null(min) && is.null(max))
    }
  )

  list(
    name = name,
    min = min,
    max = max
  ) %>%
  addClass("imola.breakpoint")
}

#' Add a breakpoint to a breakpoint system
#'
#' @description
#' Adds a breakpoint to a breakpoint system object.
#'
#' @param system A breakpoint system object created with [breakpointSystem].
#' @param breakpoint A breakpoint created with [breakpoint].
#'
#' @return A breakpoint system object.
#' @keywords breakpoints breakpoint
#' @export
addBreakpoint <- function(system, breakpoint) {
  stopifnot(
    "Given breakpoint is not a valid breakpoint()" = {
      is.breakpoint(breakpoint)
    },

    "Given system is not a valid breakpointSystem()" = {
      is.breakpointSystem(system)
    }
  )

  system$breakpoints[[breakpoint$name]] <- breakpoint

  system
}

#' Remove a breakpoint from a breakpoint system
#'
#' @description
#' Removes a breakpoint from a breakpoint system object by name.
#'
#' @param system A breakpoint system object created with [breakpointSystem].
#' @param name A string with the name of a breakpoint in the given system.
#'
#' @return A breakpoint system object.
#' @keywords breakpoints breakpoint
#' @export
removeBreakpoint <- function(system, name) {
  stopifnot(
    "Given system is not a valid breakpointSystem()" = {
      is.breakpointSystem(system)
    }
  )

  system$breakpoints[[name]] <- NULL

  system
}
