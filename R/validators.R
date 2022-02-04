#' Tests whether the object is an instance of a imola breakpoint.
#'
#' @param object Any R object.
#'
#' @return TRUE or FALSE depending ig the object is a imola breakpoint.
#' @keywords validators
is.breakpoint <- function(object) {
  is(object, "imola.breakpoint")
}

#' Tests whether the object is an instance of a imola breakpoint system.
#'
#' @param object Any R object.
#'
#' @return TRUE or FALSE depending ig the object is a imola breakpoint system.
#' @keywords validators
is.breakpointSystem <- function(object) {
  is(object, "imola.breakpoint.system")
}

#' Tests whether the object is an instance of a imola template.
#'
#' @param object Any R object.
#'
#' @return TRUE or FALSE depending ig the object is a imola template.
#' @keywords validators
is.template <- function(object) {
  is(object, "imola.template")
}
