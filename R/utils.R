#' Generate a ID
#'
#' @description
#' Generates a HTML valid ID.
#' HTML valid IDs should follow specific standards:
#'   - The ID must start with a letter (a-z or A-Z).
#'   - All subsequent characters can be letters, numbers (0-9), hyphens (-),
#'     underscores (_), colons (:), and periods (.).
#'   - Each ID must be unique within the document.
#'
#' @importFrom magrittr "%>%"
#' @importFrom stringi stri_rand_strings
#'
#' @return A valid CSS id.
#' @keywords utils internal
generateID <- function() {
  generated_id <- Sys.time() %>%
    as.integer() %>%
    paste0(stri_rand_strings(1, 12))

  getOption("imola.settings")$string_templates$generated_id %>%
    stringTemplate(id = generated_id)
}

#' Evaluate a string template
#'
#' @description
#' Processes a string template in the [htmlTemplate] format into a valid string
#' with no placeholders. The string must use the [htmlTemplate] format, meaning
#' placeholders are marked using the {{placeholder}} convention.
#'
#' @param string The string template. Uses the same format as the [htmlTemplate]
#'   function from shiny. placeholders in the template should use the
#'   {{placeholder}} format.
#' @param ... Named arguments to use in the template string. All placeholders
#'   in the template string must have a corresponding named argument.
#'
#' @importFrom magrittr "%>%"
#' @importFrom shiny htmlTemplate
#'
#' @return A string.
#' @keywords utils internal
stringTemplate <- function(string, ...) {
  string %>%
    htmlTemplate(text_ = ., ...) %>%
    as.character()
}

#' Evaluate a css template
#'
#' @description
#' Applies a CSS statement template stored in the package settings. These
#' templates use the [htmlTemplate] format, meaning placeholders are marked
#' using the {{placeholder}} convention.
#' Each placeholder value should be passed as a named argument to the function
#' using the placeholder value as a name.
#' Used primarily as a shorthand to [stringTemplate] for stored templates.
#'
#' @param template The template name to use. Available templates are saved in
#'   options, under `getOption("imola.settings")$string_templates`.
#' @param ... Named arguments to use in the template string. All placeholders
#'   in the template must have a corresponding named argument.
#'
#' @importFrom magrittr "%>%"
#'
#' @return A valid CSS string.
#' @keywords utils internal
stringCSSRule <- function(template, ...) {
  getOption("imola.settings")$string_templates[[template]] %>%
    stringTemplate(...)
}

#' Process HTML content
#'
#' @description
#' Adds a css class to any HTML elements from the content that are named and
#' which name is in the areas vector for names. This allows content to be
#' assigned to the grid areas via named argument while still allowing other
#' generic HTML tag attributes to be used.
#'
#' @param content A (named) list of HTML elements.
#' @param areas The names in content that should have a class added.
#'
#' @importFrom stringi stri_remove_empty
#' @importFrom magrittr "%<>%"
#' @importFrom shiny tagAppendAttributes
#' @importFrom htmltools tagQuery
#'
#' @return A list of HTML elements.
#' @keywords utils internal
processContent <- function(content, areas) {
  for (name in stri_remove_empty(names(content))) {
    if (name %in% areas) {

      tags <- content[[name]] %>% htmltools::tagQuery()
      tags$addClass(name)

      content[[name]] <- tags$allTags()
      names(content) <- replace(names(content), names(content) == name, "")
    }
  }
  content
}

#' Process Object to css
#'
#' @description
#' Converts a R List or vector object into a valid css string. Used primarily
#' to convert normalized attribute values into css values during processing.
#'
#' @param value List or vector with the values to be converted into css
#' @param property The target css property for which the value will be used.
#'
#' @return  string containing a valid css value.
#' @keywords utils internal
valueToCSS <- function(value, property) {
  if (property == "grid-template-areas") {
    value %<>%
      lapply(function(row) {
        row %>% paste0(collapse = " ") %>% paste0("'", ., "'")
      })
  }

  value %>% unlist() %>% paste0(collapse = " ")
}

#' Create media rule template
#'
#' @description
#' Creates a valid glue::glue string template for a css media query.
#' Used internally to generate a breakpoint specific wrapper.
#'
#' @param options The options for the required template. if no valid
#'   values are given, a non media query template is created instead.
#'
#' @importFrom glue glue
#'
#' @return A valid glue::glue template string to be processed later.
#' @keywords utils internal
mediaRuleTemplate <- function(options) {
  if (is.null(options$min) && is.null(options$max)) {
    return("{{rules}}")
  }

  stringTemplate(
    getOption("imola.settings")$string_templates$media_rule,
    min = paste0(ifelse(
      is.null(options$min), "", glue("and (min-width: {options$min}px) ")
    )),
    max = paste0(ifelse(
      is.null(options$max), "", glue("and (max-width: {options$max}px) ")
    )),
    rules = "{{rules}}"
  )
}

#' Import a settings file
#'
#' @description
#' Reads the content of a yaml settings file from the package directory.
#'
#' @param file The file name to read. Settings files are stored in the package
#'   installation directory and include different settings and options.
#'
#' @importFrom yaml read_yaml
#' @importFrom magrittr "%>%"
#'
#' @return A list object containing the content of the settings yaml file
#' @keywords utils internal
readSettingsFile <- function(file) {
  file %>%
    paste0("settings/", ., ".yml") %>%
    system.file(package = "imola") %>%
    yaml::read_yaml()
}

#' Add object class
#'
#' @description
#' Adds a class to a object
#'
#' @param object Any R object.
#' @param class A string representing a object class.
#' @importFrom yaml read_yaml
#'
#' @importFrom magrittr "%<>%"
#'
#' @return The given R object with the additional class.
#' @keywords utils internal
addClass <- function(object, class) {
  object %>% {
    class(.) %<>%
      append(class)
    .
  }
}
