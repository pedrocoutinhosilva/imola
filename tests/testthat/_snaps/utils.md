# processContent works when no areas are given

    Code
      imola:::processContent(list(`area-1` = div(), `area-2` = div()), NULL)
    Output
      $`area-1`
      <div></div>
      
      $`area-2`
      <div></div>
      

# processContent works when no areas are empty

    Code
      imola:::processContent(list(`area-1` = div(), `area-2` = div()), c())
    Output
      $`area-1`
      <div></div>
      
      $`area-2`
      <div></div>
      

# processContent works when only some areas are given

    Code
      imola:::processContent(list(`area-1` = div(), `area-2` = div()), c("area-1"))
    Output
      [[1]]
      <div class="area-1"></div>
      
      $`area-2`
      <div></div>
      

# processContent works when only all areas are given

    Code
      imola:::processContent(list(`area-1` = div(), `area-2` = div()), c("area-1",
        "area-2"))
    Output
      [[1]]
      <div class="area-1"></div>
      
      [[2]]
      <div class="area-2"></div>
      

# readSettingsFile loads a file successfully

    Code
      imola:::readSettingsFile("config")
    Output
      $default_system
      [1] "bootstrap3"
      
      $css
      $css$grid
      $css$grid$fill_page
      [1] " html, body { min-height: 100vh; width: 100%; margin: 0; padding: 0; display: flex; }"
      
      
      $css$flexbox
      $css$flexbox$fill_page
      [1] " html, body { min-height: 100vh; width: 100%; margin: 0; padding: 0; } .grid-page-wrapper { min-height: 100vh; }"
      
      
      
      $string_templates
      $string_templates$generated_id
      [1] "grid_{{id}}"
      
      $string_templates$media_rule
      [1] " @media all {{min}} {{max}} { {{rules}} }"
      
      $string_templates$grid_base
      [1] ".{{id}} {width: 100%; display: grid;}"
      
      $string_templates$grid_auto_fill
      [1] ".{{id}} {height: 100%;}"
      
      $string_templates$grid_parent
      [1] " .{{id}} { {{attribute}}: {{value}}; }"
      
      $string_templates$grid_cell
      [1] " .{{id}} > .{{child_id}} { {{attribute}}: {{value}}; }"
      
      $string_templates$flex_base
      [1] ".{{id}} {height: 100%; width: 100%; display: flex;}"
      
      $string_templates$flex_cell
      [1] " .{{id}} > *:nth-child({{child_index}}) { {{attribute}}: {{value}}; }"
      
      $string_templates$messages
      $string_templates$messages$wrong_template_type
      [1] " Given template has the wrong type for the panel. Expected {{type}} but provided template is {{template_type}}. (Have you used gridTemplate() to create your template?) "
      
      $string_templates$messages$missing_template
      [1] " The grid template {{template}} for {{type}} does not exist. Check listTemplates() to see available templates. (Is the template you're looking for registered for {{type}} panels?) "
      
      
      
      $property_mapping
      $property_mapping$areas
      [1] "grid-template-areas"
      
      $property_mapping$rows
      [1] "grid-template-rows"
      
      $property_mapping$columns
      [1] "grid-template-columns"
      
      $property_mapping$justify_items
      [1] "justify-items"
      
      $property_mapping$align_items
      [1] "align-items"
      
      $property_mapping$gap
      [1] "gap"
      
      $property_mapping$direction
      [1] "flex-direction"
      
      $property_mapping$wrap
      [1] "flex-wrap"
      
      $property_mapping$justify_content
      [1] "justify-content"
      
      $property_mapping$align_content
      [1] "align-content"
      
      $property_mapping$flex
      [1] "flex"
      
      $property_mapping$grow
      [1] "flex-grow"
      
      $property_mapping$shrink
      [1] "flex-shrink"
      
      $property_mapping$basis
      [1] "flex-basis"
      
      

