#' Generates all required css for a set of attributes, for a grid wrapper.
#'
#' @param attributes Normalized attribute list to generate css from.
#' @param id The id of the parent wrapper element.
#' @param unique_areas Unique names of areas that the grid contains.
#' @param breakpoint_system Media breakpoints to use.
#'
#' @importFrom magrittr "%>%"
#' @importFrom magrittr "%<>%"
#'
#' @return A string with all placeholders replaced.
generateGridCSS <- function(attributes, id, unique_areas, breakpoint_system) {
  mapping <- getOption("imola.settings")$property_mapping

  styles <- list()
  for (attribute in names(attributes)) {
    styles[[attribute]] <- generateCSSPropertyStyles(
      attributes[[attribute]],
      mapping[[attribute]],
      id,
      breakpoint_system
    )
  }

  unique_areas %<>%
    generateGridAreaCSS(id)

  c(styles, unique_areas) %>%
    unlist() %>%
    paste0(collapse = " ") %>%
    HTML()
}

#' Generates the requires css statements for a specific set of grid areas. This
#'   includes the css required to position each child element into each of the
#'   named grid area.
#'
#' @param areas Unique names of areas for which css rules must be generated.
#' @param id The id of the parent wrapper element.
#'
#' @importFrom magrittr "%<>%"
#'
#' @return A vector of valid css strings.
generateGridAreaCSS <- function(areas, id) {
  styles <- c()
  for (area in areas) {
    styles %<>% c(stringCSSRule("grid_cell",
      id = id,
      child_id = area,
      attribute = "grid-area",
      value = area
    ))
  }

  styles %>%
    unlist() %>%
    paste0(collapse = " ") %>%
    HTML()
}

#' Generates all required css for a set of attributes, for a flex wrapper.
#'
#' @param attributes Normalized attribute list to generate css from.
#' @param id The id of the parent wrapper element.
#' @param number_children Number of child elements in the wrapper. Required to
#'   generate rules for flex elements.
#' @param breakpoint_system Media breakpoints to use.
#'
#' @importFrom magrittr "%>%"
#'
#' @return A string with all placeholders replaced.
generateFlexCSS <- function(attributes,
                            id,
                            number_children,
                            breakpoint_system) {
  mapping <- getOption("imola.settings")$property_mapping

  wrapper_styles <- list(
    direction = attributes$direction,
    wrap = attributes$wrap,
    justify_content = attributes$justify_content,
    align_items = attributes$align_items,
    align_content = attributes$align_content,
    gap = attributes$gap
  )

  for (attribute in names(wrapper_styles)) {
    wrapper_styles[[attribute]] <- generateCSSPropertyStyles(
      attributes[[attribute]],
      mapping[[attribute]],
      id,
      breakpoint_system
    )
  }

  children_styles <- list(
    flex = attributes$flex,
    grow = attributes$grow,
    shrink = attributes$shrink,
    basis = attributes$basis
  ) %>% generateFlexChildrenCSS(id, number_children, breakpoint_system)

  c(wrapper_styles, children_styles) %>%
    unlist() %>%
    paste0(collapse = " ") %>%
    HTML()
}

#' Generates all required css for a set of children attributes,
#'   for a flex wrapper.
#'
#' @param attributes Normalized attribute list to generate css from.
#' @param id The id of the parent wrapper element.
#' @param number_children Number of child elements in the wrapper. Required to
#'   generate rules for flex elements.
#' @param breakpoint_system Media breakpoints to use.
#'
#' @importFrom magrittr "%>%"
#' @importFrom magrittr "%<>%"
#'
#' @return A string with all placeholders replaced.
generateFlexChildrenCSS <- function(attributes,
                                    id,
                                    number_children,
                                    breakpoint_system) {
  mapping <- getOption("imola.settings")$property_mapping

  css_rules <- ""
  for (attribute in names(attributes)) {
    for (breakpoint in names(attributes[[attribute]])) {
      attribute_value <- attributes[[attribute]][[breakpoint]]

      # If there are less child values than rules given, repeat the
      # values until each child has a value assigned
      if (number_children > length(attribute_value)) {
        attribute_value <- rep(
          attribute_value,
          ceiling(number_children / length(attribute_value))
        )
      }

      rule_wrapper <- ifelse(
        breakpoint == "default",
        "{rules}",
        mediaRuleTemplate(breakpoint_system[[breakpoint]])
      )

      for (rule_index in seq_len(number_children)) {
        if (!is.na(attribute_value[rule_index])) {
          css_rules %<>% c(paste0(glue(
            rule_wrapper,
            rules = stringCSSRule("flex_cell",
              id = id,
              child_index = rule_index,
              attribute = mapping[[attribute]],
              value = attribute_value[rule_index]
            )
          )))
        }
      }
    }
  }

  css_rules
}

#' Generates the requires css statements for a specific css property. It will
#'   iterated over all breakpoints in the given value and return all statements
#'   for all breakpoints in a vector format.
#'
#' @param value Normalized attribute value list to generate css from.
#' @param property The type of grid to generate css for.
#' @param id The id of the parent wrapper element.
#' @param breakpoint_system Media breakpoints to use.
#'
#' @importFrom magrittr "%<>%"
#'
#' @return A vector of valid css strings.
generateCSSPropertyStyles <- function(value, property, id, breakpoint_system) {
  if (is.null(value)) {
    return(NULL)
  }

  styles <- c()
  for (breakpoint in names(value)) {
    styles %<>% c(stringTemplate(
      mediaRuleTemplate(breakpoint_system[[breakpoint]]),
      rules = stringCSSRule("grid_parent",
        id = id,
        attribute = property,
        value = valueToCSS(value[[breakpoint]], property)
      )
    ))
  }

  styles
}
