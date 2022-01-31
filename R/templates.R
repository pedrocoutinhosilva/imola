#' Lists all available grid and flex templates. If type is given, returns only
#'   templates for the given grid type. Templates are collections of
#'   arguments that can be grouped and stored for later usage via the "template"
#'   argument of panel and page functions.
#'
#' @param type Optional argument for what type of css templates to return.
#'   value must be either "grid" or "flex". If no type is given, all templates
#'   of all types are returned,
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

#' Registers a new css template for future use. Depending on the given type,
#'   the template will then be available to be passed as an argument to a panel
#'   or page function of that specific type. Templates are collections of
#'   arguments that can be grouped and stored for later usage via the "template"
#'   argument of panel and page functions.
#'
#' @param type The type of css grid for which the template can be used
#' @param name A unique name for the template. If a template with the same type
#'   and name exists, it will simply be overwritten.
#' @param ... Collection of valid arguments that can be passed to a panel of
#'   the given type (see gridPanel() and FlexPanel() for all options)
#' @param breakpoint_system Optional breakpoint system to use in the template.
#'   by default it will simply use the current active system but a built in
#'   or custom system can also be passed. You ca find built in breakpoint
#'   systems under getOption("imola.breakpoints")
#'
#' @importFrom utils modifyList
#' @importFrom yaml write_yaml
#'
#' @return No return value, called for side effects
#' @keywords templates
#' @export
registerTemplate <- function(type, name, ..., breakpoint_system = getBreakpointSystem()) {
  listTemplates <- listTemplates()
  listTemplates[[type]][[name]] <- modifyList(
    list(...),
    list(breakpoint_system = breakpoint_system)
  )

  options(imola.templates = listTemplates)
}

#' Returns a imola template as an object for future use. Depending on the
#'   given type, the template will then be available to be passed as an
#'   argument to a panel or page function of that specific type. Templates are
#'   collections of arguments that can be grouped and stored for later usage
#'   via the "template" argument of panel and page functions.
#'
#' @param type The type of css grid for which the template can be used
#' @param ... Collection of valid arguments that can be passed to a panel of
#'   the given type (see gridPanel() and FlexPanel() for all options)
#' @param breakpoint_system Optional breakpoint system to use in the template.
#'   by default it will simply use the current active system but a built in
#'   or custom system can also be passed. You ca find built in breakpoint
#'   systems under getOption("imola.breakpoints")
#'
#' @importFrom utils modifyList
#'
#' @return A list with template details
#' @keywords templates
#' @export
makeTemplate <- function(type, ..., breakpoint_system = getBreakpointSystem()) {
  template <- modifyList(
    list(...),
    list(
      type = type,
      breakpoint_system = breakpoint_system
    )
  )

  template
}

#' @param template A string with the template name if the template is registered
#'   or the return of calling makeTemplate(). If using a string with a name, the
#'   type argument must also be provided.
#' @param type The type of css grid for which the template can be used. Optional
#'   when exporting a registered template.
#' @param path A path ending in a file name with a .yaml extension to export
#'   the template to. Allows exporting templates as a yaml file for
#'   future usage.
exportTemplate <- function(template, type = NULL, path) {
  if (!is.list(template)) {
    template <- listTemplates()[[type]][[template]]
  }

  yaml::write_yaml(template, path)
}

#' Deletes an existing css template from the available list of templates for the
#'   given grid type. Templates are collections of arguments
#'   that can be grouped and stored for later usage via the "template"
#'   argument of panel and page functions.
#'
#' @param type The type of css grid of the template to remove.
#' @param name The name of the tempalte to remove.
#'
#' @return No return value, called for side effects
#' @keywords templates
#' @export
unregisterTemplate <- function(type, name) {
  listTemplates <- listTemplates()
  listTemplates[[type]][[name]] <- NULL

  options(imola.templates = listTemplates)
}

#' Merges a set of attributes with a given template. To avoid redundanct
#'   attributes being added to the final list, a list of default values (based
#'   of the specific panel creation callback formals) is used to validate the
#'   need of the argument value in the final list.
#'
#' @param attributes The manually given attribute values that will take priority
#'   during the merge.
#' @param template The name of the template to merge, or the resulting value
#'   from using makeTemplate() to generate a template object.
#' @param defaults The default values of the grid callback.
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
    if(!identical(template$type, type)) {
      messages <- getOption("imola.settings")$string_templates$messages
      stop(messages$wrong_template_type %>%
        stringTemplate(template_type = template$type, type = type))
    }

    options <- template
  } else {
    options <- getOption("imola.templates")[[type]][[template]]
  }

  for (name in names(options)) {
    manual_value <- attributes[[name]]
    template_value <- options[[name]]
    default_value <- defaults[[name]]

    if (!is.null(template_value) && identical(manual_value, default_value)) {
      attributes[[name]] <- template_value
    } else {
      attributes[[name]] <- manual_value
    }
  }

  attributes
}
