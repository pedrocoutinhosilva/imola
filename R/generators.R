#' Creates styles for css grid attributes.
#'
#' @param attributes Normalized attribute list.
#' @param id The id of the parent wrapper element.
#' @param areas Area names in the grid.
#' @param system A breakpoint system object to use.
#'
#' @importFrom magrittr "%>%" "%<>%"
#'
#' @keywords generators internal
#' @return A vector of valid css strings.
generateGridCSS <- function(attributes, id, areas, system) {
  mapping <- getOption("imola.settings")$property_mapping

  styles <- list()
  for (attribute in names(attributes)) {
    styles[[attribute]] <- generateCSSPropertyStyles(
      attributes[[attribute]],
      mapping[[attribute]],
      id,
      system
    )
  }

  areas %<>%
    generateGridAreaCSS(id)

  c(styles, areas) %>%
    unlist() %>%
    paste0(collapse = " ") %>%
    HTML()
}

#' Creates styles for css grid areas.
#'
#' @description
#' Creates the requires css statements for a specific set of grid areas.
#' This includes the css required to position each child element into
#' each of the named grid area.
#'
#' @param areas Vector of strings with the area names.
#' @param id The id of the parent wrapper element.
#'
#' @importFrom magrittr "%>%"
#'
#' @keywords generators internal
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

#' Creates styles for a css flex element.
#'
#' @description
#' Creates the requires css statements for a specific set of flex
#' attributes. This includes the css required to position each child
#' element into the flex element.
#'
#' @param attributes Normalized attribute list.
#' @param id The id of the parent element.
#' @param number_children Number of child elements.
#' @param system A breakpoint system object to use.
#'
#' @importFrom magrittr "%>%"
#'
#' @keywords generators internal
#' @return A vector of valid css strings.
generateFlexCSS <- function(attributes,
                            id,
                            number_children,
                            system) {
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
      system
    )
  }

  children_styles <- list(
    flex = attributes$flex,
    grow = attributes$grow,
    shrink = attributes$shrink,
    basis = attributes$basis
  ) %>% generateFlexChildrenCSS(id, number_children, system)

  c(wrapper_styles, children_styles) %>%
    unlist() %>%
    paste0(collapse = " ") %>%
    HTML()
}

#' Creates styles for the children of a css flex element.
#'
#' @description
#' Creates css required to position each child
#' element into the flex element.
#'
#' @param attributes Normalized attribute list.
#' @param id The id of the parent wrapper element.
#' @param number_children Number of child elements in the wrapper. Required to
#'   generate rules for flex elements.
#' @param system A breakpoint system object to use.
#'
#' @importFrom magrittr "%<>%"
#'
#' @keywords generators internal
#' @return A vector of valid css strings.
generateFlexChildrenCSS <- function(attributes,
                                    id,
                                    number_children,
                                    system) {

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
        mediaRuleTemplate(system$breakpoints[[breakpoint]])
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

#' Creates styles for a css property.
#'
#' @description
#' Creates the required css statements for a specific css property. This
#' includes the rules for all breakpoints.
#'
#' @param value Normalized attribute value list.
#' @param property The css attribute to generate rules for.
#' @param id The id of the parent element.
#' @param system A breakpoint system object to use.
#'
#' @importFrom magrittr "%<>%"
#'
#' @keywords generators internal
#' @return A vector of valid css strings.
generateCSSPropertyStyles <- function(value, property, id, system) {
  if (is.null(value)) {
    return(NULL)
  }

  styles <- c()
  for (breakpoint in names(value)) {
    styles %<>% c(stringTemplate(
      mediaRuleTemplate(system$breakpoints[[breakpoint]]),
      rules = stringCSSRule("grid_parent",
        id = id,
        attribute = property,
        value = valueToCSS(value[[breakpoint]], property)
      )
    ))
  }

  styles
}
