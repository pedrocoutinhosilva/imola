#' Custom print function for a breakpoint object.
#'
#' @param x the object to print.
#' @param ... Additional arguments.
#'
#' @return No return value, called for side effects.
#' @keywords printer
#' @export
print.imola.breakpoint <- function(x, ...) {
  cat("Imola Breakpoint\n")
  cat("Name: ", x$name, "\n")
  cat("\n")
  cat("Affect Screen Sizes:\n")
  cat("Minimum: ", ifelse(is.null(x$min), "Any size below minimum", paste(x$min, "px")), "\n")
  cat("Maximum: ", ifelse(is.null(x$max), "Any size above minimum", paste(x$max, "px")), "\n")
}

#' Custom print function for a breakpoint system object.
#'
#' @param x the object to print.
#' @param ... Additional arguments.
#'
#' @return No return value, called for side effects.
#' @keywords printer
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

#' Custom print function for a template object.
#'
#' @param x the object to print.
#' @param ... Additional arguments.
#'
#' @return No return value, called for side effects.
#' @keywords printer
#' @export
print.imola.template <- function(x, ...) {
  cat("Imola Template\n")
  cat("Name: ", x$name, "\n")
  cat("Type: ", x$type, "\n")
  cat("description: ", ifelse(!is.null(x$description), x$description, "No description"), "\n")
  cat("\n")
  cat("Attribute values:\n")
  print(x$attributes)
  cat("-----------------------------\n")
  print(x$breakpoint_system)
}
