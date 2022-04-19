#' Tests whether the object is an instance of a imola breakpoint.
#'
#' @param object Any R object.
#'
#' @return TRUE or FALSE depending if the object is a imola breakpoint.
#' @keywords validators internal
is.breakpoint <- function(object) {
  "imola.breakpoint" %in% class(object)
}

#' Tests whether the object is an instance of a imola breakpoint system.
#'
#' @param object Any R object.
#'
#' @return TRUE or FALSE depending if the object is a imola breakpoint system.
#' @keywords validators internal
is.breakpointSystem <- function(object) {
  "imola.breakpoint.system" %in% class(object)
}

#' Tests whether the object is an instance of a imola template.
#'
#' @param object Any R object.
#'
#' @return TRUE or FALSE depending if the object is a imola template.
#' @keywords validators internal
is.template <- function(object) {
  "imola.template" %in% class(object)
}
