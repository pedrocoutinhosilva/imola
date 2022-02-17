# Breakpoint creation

    Code
      breakpoint("breakpoint_min_only", min = 999)
    Output
      Imola Breakpoint
      Name:  breakpoint_min_only 
      
      Affect Screen Sizes:
      Minimum:  999 px 
      Maximum:  Any size above minimum 

---

    Code
      breakpoint("breakpoint_max_only", max = 1000)
    Output
      Imola Breakpoint
      Name:  breakpoint_max_only 
      
      Affect Screen Sizes:
      Minimum:  Any size below minimum 
      Maximum:  1000 px 

---

    Code
      breakpoint("breakpoint_min_max", min = 999, max = 1000)
    Output
      Imola Breakpoint
      Name:  breakpoint_min_max 
      
      Affect Screen Sizes:
      Minimum:  999 px 
      Maximum:  1000 px 

# Breakpoint system creation

    Code
      breakpointSystem("single_breakpoint", breakpoint("breakpoint_max_only", max = 1000),
      breakpoint("breakpoint_min_max", min = 999, max = 1000))
    Output
      Imola Breakpoint System
      Name:  single_breakpoint 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      breakpoint_max_only            NULL                       1000                     
      breakpoint_min_max             999                        1000                     
      -----------------------------

---

    Code
      breakpointSystem("multiple_breakpoints", breakpoint("breakpoint_max_only", max = 1000),
      breakpoint("breakpoint_min_max", min = 999, max = 1000))
    Output
      Imola Breakpoint System
      Name:  multiple_breakpoints 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      breakpoint_max_only            NULL                       1000                     
      breakpoint_min_max             999                        1000                     
      -----------------------------

# Breakpoint add removal

    Code
      system
    Output
      Imola Breakpoint System
      Name:  single_breakpoint 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      breakpoint_max_only            NULL                       1000                     
      breakpoint_min_max             999                        1000                     
      new                            999                        1000                     
      -----------------------------

---

    Code
      system
    Output
      Imola Breakpoint System
      Name:  single_breakpoint 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      breakpoint_max_only            NULL                       1000                     
      breakpoint_min_max             999                        1000                     
      -----------------------------

# List breakpoint systems

    Code
      listBreakpointSystems()
    Output
      $bootstrap3
      Imola Breakpoint System
      Name:  bootstrap3 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      xs                             NULL                       575                      
      sm                             NULL                       767                      
      md                             NULL                       991                      
      lg                             NULL                       1199                     
      xl                             1200                       NULL                     
      -----------------------------
      
      $bootstrap5
      Imola Breakpoint System
      Name:  bootstrap5 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      sm                             576                        NULL                     
      md                             768                        NULL                     
      lg                             992                        NULL                     
      xl                             1200                       NULL                     
      xxl                            1400                       NULL                     
      -----------------------------
      
      $bulma
      Imola Breakpoint System
      Name:  bulma 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      tablet                         769                        NULL                     
      desktop                        1024                       NULL                     
      widescreen                     1216                       NULL                     
      fullhd                         1408                       NULL                     
      -----------------------------
      
      $foundation
      Imola Breakpoint System
      Name:  foundation 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      tablet                         769                        NULL                     
      desktop                        1024                       NULL                     
      widescreen                     1216                       NULL                     
      fullhd                         1408                       NULL                     
      -----------------------------
      

# Register breakpoint systems

    Code
      listBreakpointSystems()
    Output
      $bootstrap3
      Imola Breakpoint System
      Name:  bootstrap3 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      xs                             NULL                       575                      
      sm                             NULL                       767                      
      md                             NULL                       991                      
      lg                             NULL                       1199                     
      xl                             1200                       NULL                     
      -----------------------------
      
      $bootstrap5
      Imola Breakpoint System
      Name:  bootstrap5 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      sm                             576                        NULL                     
      md                             768                        NULL                     
      lg                             992                        NULL                     
      xl                             1200                       NULL                     
      xxl                            1400                       NULL                     
      -----------------------------
      
      $bulma
      Imola Breakpoint System
      Name:  bulma 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      tablet                         769                        NULL                     
      desktop                        1024                       NULL                     
      widescreen                     1216                       NULL                     
      fullhd                         1408                       NULL                     
      -----------------------------
      
      $foundation
      Imola Breakpoint System
      Name:  foundation 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      tablet                         769                        NULL                     
      desktop                        1024                       NULL                     
      widescreen                     1216                       NULL                     
      fullhd                         1408                       NULL                     
      -----------------------------
      
      $test_system
      Imola Breakpoint System
      Name:  test_system 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      breakpoint_max_only            NULL                       1000                     
      breakpoint_min_max             999                        1000                     
      -----------------------------
      

---

    Code
      listBreakpointSystems()
    Output
      $bootstrap3
      Imola Breakpoint System
      Name:  bootstrap3 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      xs                             NULL                       575                      
      sm                             NULL                       767                      
      md                             NULL                       991                      
      lg                             NULL                       1199                     
      xl                             1200                       NULL                     
      -----------------------------
      
      $bootstrap5
      Imola Breakpoint System
      Name:  bootstrap5 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      sm                             576                        NULL                     
      md                             768                        NULL                     
      lg                             992                        NULL                     
      xl                             1200                       NULL                     
      xxl                            1400                       NULL                     
      -----------------------------
      
      $bulma
      Imola Breakpoint System
      Name:  bulma 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      tablet                         769                        NULL                     
      desktop                        1024                       NULL                     
      widescreen                     1216                       NULL                     
      fullhd                         1408                       NULL                     
      -----------------------------
      
      $foundation
      Imola Breakpoint System
      Name:  foundation 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      tablet                         769                        NULL                     
      desktop                        1024                       NULL                     
      widescreen                     1216                       NULL                     
      fullhd                         1408                       NULL                     
      -----------------------------
      

# Setting active breakpoint system

    Code
      getBreakpointSystem()
    Output
      Imola Breakpoint System
      Name:  bulma 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      tablet                         769                        NULL                     
      desktop                        1024                       NULL                     
      widescreen                     1216                       NULL                     
      fullhd                         1408                       NULL                     
      -----------------------------

# Setting active breakpoint system from a system object

    Code
      getBreakpointSystem()
    Output
      Imola Breakpoint System
      Name:  single_breakpoint 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      breakpoint_max_only            NULL                       1000                     
      breakpoint_min_max             999                        1000                     
      -----------------------------

# Reset active breakpoint system

    Code
      getBreakpointSystem()
    Output
      Imola Breakpoint System
      Name:  bootstrap3 
      description:  No description 
      
      
      Available Breakpoints (name)   Minimum screen size (px)   Maximum screen size (px) 
      -----------------------------  -------------------------  -------------------------
      xs                             NULL                       575                      
      sm                             NULL                       767                      
      md                             NULL                       991                      
      lg                             NULL                       1199                     
      xl                             1200                       NULL                     
      -----------------------------

