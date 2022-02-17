#' List registered templates
#'
#' @description
#' Lists all available grid and flex templates. If type is given, returns only
#' templates for the given grid type.
#'
#' @param type Optional argument for what type of css templates to return.
#'   value must be either "grid" or "flex". If no type is given, all templates
#'   of all types are returned.
#'
#' @return A named list of css templates and specific values.
#' @keywords templates
#' @export
listTemplates <- function(type = NULL) {
  if (is.null(type)) {
    return(getOption("imola.templates"))
  }

  getOption("imola.templates")[[type]]
}

#' Create a grid template
#'
#' @description
#' Creates a imola template as an object for future use. Depending on the
#' given type, the template will then be available to be used as an
#' argument to a panel or page function of that specific type. Templates are
#' collections of arguments that can be grouped and stored for later usage
#' via the "template" argument of panel and page functions.
#'
#' @param name A string with the name that identifies the template.
#' @param type The type of css grid for which the template can be used.
#'   Value must be either "grid" or "flex".
#' @param ... Collection of valid arguments that can be passed to a panel of
#'   the given type (see [gridPanel] and [FlexPanel] for all options)
#' @param breakpoint_system Breakpoint system to use.
#' @param description Optional description with information.
#'   about the template. Can be used to pass on any additional relevant
#'   information (For example its origin or connected frameworks).
#'
#' @importFrom utils modifyList
#' @importFrom magrittr "%>%"
#'
#' @return A template object.
#' @keywords templates
#' @export
gridTemplate <- function(name,
                         type = c("grid", "flex"),
                         ...,
                         breakpoint_system = getBreakpointSystem(),
                         description = NULL) {
  list(
    name = name,
    type = type,
    description = description,
    breakpoint_system = breakpoint_system,
    attributes = list(...) %>%
      normalizeAttributes()
  ) %>%
  addClass("imola.template")
}

#' Import a template
#'
#' @description
#' Imports a template from a file.
#' Templates can be exported into a file format by using
#' [exportTemplate]
#'
#' @param path The file path of the file to import, including the file
#'   name and extension. The file name must end with a `.yaml` extension.
#'
#' @return A template object.
#' @keywords templates
#' @export
importTemplate <- function(path) {
  options <- yaml::read_yaml(path)

  stopifnot(
    "Wrong file format" = {
      !is.null(options$name)
    },
    "No attributes information" = {
      !is.null(options$attributes)
    },
    "No breakpoint system information" = {
      !is.null(options$breakpoint_system)
    }
  )

  for (single in names(options$breakpoint_system$breakpoints)) {
    options$breakpoint_system$breakpoints[[single]] <- do.call(
      breakpoint,
      options$breakpoint_system$breakpoints[[single]]
    )
  }

  normalized_system <- do.call(
    breakpointSystem,
    modifyList(
      list(
        name = options$breakpoint_system$name,
        description = options$breakpoint_system$description
      ),
      options$breakpoint_system$breakpoints
    )
  )

  do.call(
    gridTemplate,
    modifyList(
      list(
        name = options$name,
        type = options$type,
        description = options$description,
        breakpoint_system = normalized_system
      ),
      options$attributes
    )
  )
}

#' Export a template
#'
#' @description
#' Exports a template into a file for storage and later usage.
#' Exported template can be retrieved from their file form by using
#' [importTemplate].
#'
#' @param template A template
#'   object generated with [gridTemplate].
#' @param path The file path where to export the system to, including the file
#'   name and extension. The file name must end with a `.yaml` extension.
#'
#' @return No return value, called for side effects.
#' @keywords templates
#' @export
exportTemplate <- function(template, path) {
  stopifnot(
    "No valid template to export" = {
      !is.character(template)
    },
    "No valid template to export" = {
      !is.null(template)
    },
    "No attributes information. (Why are you saving a empty template?)" = {
      !is.null(template$attributes)
    }
  )

  message("Exported ", template$name, " template to ", path, ".")
  yaml::write_yaml(template, path)
}

#' Get a registered template
#'
#' @description
#' Returns a object form of a registered template by its name and type.
#'
#' @param name The name of a registered template.
#' @param type The type of css grid for which the template can be used.
#'
#' @return A template object.
#' @keywords templates
#' @export
getTemplate <- function(name, type) {
  stopifnot(
    "Type is not supported" = {
      type %in% names(getOption("imola.templates"))
    },
    "No registered template with given name" = {
      name %in% names(getOption("imola.templates")[[type]])
    }
  )

  getOption("imola.templates")[[type]][[name]]
}

#' Register a template
#'
#' @description
#' Registers a template object to make it available globally in
#' getOption("imola.templates"). After registered it can be retrieved
#' anywhere using [getTemplate].
#'
#' @param template A template object generated with [gridTemplate].
#'
#' @return No return value, called for side effects.
#' @keywords templates
#' @export
registerTemplate <- function(template) {
  stopifnot(
    "Template is not a valid gridTemplate()" = {
      is(template, "imola.template")
    }
  )

  registered_templates <- getOption("imola.templates")
  registered_templates[[template$type]][[template$name]] <- template

  message("Template has been registered for global usage")
  options(imola.templates = registered_templates)
}

#' Unregister a template
#'
#' @description
#' Removes a globally registered template from
#' `getOption("imola.templates")`.
#'
#' @param name A string with the name of a registered template.
#'   Registered templates are available in `getOption("imola.templates")`.
#' @param type The type of css grid for which the template can be used.
#'
#' @return No return value, called for side effects.
#' @keywords templates
#' @export
unregisterTemplate <- function(name, type) {
  if (is.null(getOption("imola.templates")[[type]][[name]])) {
    warning("No template registered with that name and type")
    return()
  }

  registered_templates <- getOption("imola.templates")
  registered_templates[[type]][[name]] <- NULL

  options(imola.templates = registered_templates)
}

#' Apply a template to a attribute list
#'
#' @description
#' Merges a set of attributes with a given template. To avoid redundant
#' attributes being added to the final list, a list of default values (based
#' of the specific panel creation callback formals) is used to validate the
#' need of a argument value in the final list.
#'
#' @param attributes The manually given attribute values that will take priority
#'   during the merge.
#' @param template The name of the template to merge, or a template object.
#' @param defaults Default attribute values to ignore from attributes.
#' @param type The type of css grid of the template.
#'
#' @return A named list of css attributes that can be used to generate a html
#'   element style rules of the given type.
#' @keywords templates
applyTemplate <- function(attributes, template, defaults, type) {
  if (is.null(template)) {
    return(attributes)
  }

  if (!is.list(template) &&
      is.null(getOption("imola.templates")[[type]][[template]])) {

    messages <- getOption("imola.settings")$string_templates$messages
    stop(messages$missing_template %>%
      stringTemplate(template = template, type = type))
  }

  if (is.list(template)) {
    if (!identical(template$type, type)) {
      messages <- getOption("imola.settings")$string_templates$messages
      stop(messages$wrong_template_type %>%
        stringTemplate(template_type = template$type, type = type))
    }

    options <- template
  } else {
    options <- getOption("imola.templates")[[type]][[template]]
  }

  for (name in names(options$attributes)) {
    manual_value <- attributes[[name]]
    template_value <- options$attributes[[name]]
    default_value <- defaults[[name]]

    if (!is.null(template_value) && identical(manual_value, default_value)) {
      attributes[[name]] <- template_value
    } else {
      attributes[[name]] <- manual_value
    }
  }

  attributes
}
