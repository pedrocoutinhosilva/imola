#' Normalize a list of attributes
#'
#' @description
#' Iterates through the list of attributes and applies [normalizeAttribute] to
#' each of them.
#'
#' @param attributes A named list of attribute values.
#'
#' @keywords normalizer internal
#' @return A named list.
normalizeAttributes <- function(attributes) {
  for (attribute in names(attributes)) {
    attributes[[attribute]] <- normalizeAttribute(attributes[[attribute]])
  }

  attributes
}

#' Normalize a attribute
#'
#' @description
#' Converts the values of an attribute passed to a grid or flex function into
#' a normalized named list.
#' Does nothing if the attribute is already a named list in the correct format.
#'
#' @param attribute A attribute value.
#' @param simplify Should each attribute value be simplified into a single
#'   string.
#'
#' @keywords normalizer internal
#' @return A named list.
normalizeAttribute <- function(attribute, simplify = FALSE) {
  if (is.null(attribute)) {
    return(attribute)
  }

  if (is.numeric(attribute)) {
    attribute <- as.character(attribute)
  }

  if (is.null(names(attribute))) {
    attribute <- list(default = attribute)
  }

  sapply(attribute, function(breakpoint) {
    if (is.vector(breakpoint) && is.atomic(breakpoint)) {
      lapply(breakpoint, . %>% {
          strsplit(., split = " ")[[1]]
      })
    } else {
      breakpoint
    }
  }, simplify = simplify)
}
