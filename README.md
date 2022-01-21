# imola <img src="man/figures/logo.svg" align="right" alt="" width="130" />
<!-- badges: start -->
[![R-CMD-check](https://github.com/pedrocoutinhosilva/imola/workflows/R-CMD-check/badge.svg)](https://CRAN.R-project.org/package=imola)
[![cranlogs](https://www.r-pkg.org/badges/version/imola)](https://CRAN.R-project.org/package=imola)
[![cranlogs](https://cranlogs.r-pkg.org/badges/imola)](https://CRAN.R-project.org/package=imola)
[![total](https://cranlogs.r-pkg.org/badges/grand-total/imola)](https://CRAN.R-project.org/package=imola)
<!-- badges: end -->

An interface to create grid and flexbox CSS layouts for your R/Shiny dashboards, directly from R.

Imola (named after the first city ever to be given a technical blueprint by Leonardo da Vinci) aims at giving you more layout creation options directly in R/shiny, without the hassle of having to create custom CSS every time.

##### CSS Layouts in shiny, made simple
You can now easily leverage typical CSS layouts (grid and Flexbox) directly in your UI functions, including support for media breakpoints to fit different screen sizes and devices.

##### Built in templates, or create your own
Save your favorite layouts for later use via the existing templating system and simply use it in as many elements as you need.

If layout creation isn't your thing, imola also comes with a built in collection of templates for traditionally used web layouts, making it even easier to spice up your dashboards!

##### Demos to get you started
You can find a few deployed demos showcasing some of the power of imola:

-   Built in template layouts: https://sparktuga.shinyapps.io/imolatemplates/

---

## installation
###### 1 - Install the package:

```R
# Install released version from CRAN
install.packages('imola')

# Or the most recent development version from github:
devtools::install_github('pedrocoutinhosilva/imola')
```

###### 2 - Include the library in your project:
```R
# global.R
library(imola)
```
You are now ready to go!

Looking for help on how to start? Make sure to check the built in examples and vignettes for help and usage examples.

---

## Usage

Check `vignette("imola")` on how to get started, and other follow up vignettes for even more information regarding css flexbox and grid and their imola counterparts.

Looking for a specific topic to jump into? Use the following vignettes for a quick start:

-   `vignette("imola-flexbox")` for details on `flexPanel()` and `flexPage()`.
-   `vignette("imola-grid")` for details on `gridPanel()` and `gridPage()`.
-   `vignette("imola-templates")` for information on using imola's templating engine.
-   `vignette("imola-breakpoints")` for information on using imola's breakpoint systems.
