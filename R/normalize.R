#' Applies the normalizeAttribute() function to a full attribute list.
#'
#' @param attributes The values to process
#'
#' @keywords internal normalizer
#' @return A named list.
normalizeAttributes <- function(attributes) {
  for (attribute in names(attributes)) {
    attributes[[attribute]] <- normalizeAttribute(attributes[[attribute]])
  }

  attributes
}

#' Converts non named list attributes into a named list.
#' Does nothing if the attribute is already a list in the correct format.
#'
#' @param attribute The value to process
#' @param simplify Boolean flag if the attribute should be simplified into
#'   single strings.
#'
#' @keywords internal normalizer
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
