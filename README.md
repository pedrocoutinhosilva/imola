# imola <img src="man/figures/logo.svg" align="right" alt="" width="130" />
<!-- badges: start -->
[![R-CMD-check](https://github.com/pedrocoutinhosilva/imola/workflows/R-CMD-check/badge.svg)](https://CRAN.R-project.org/package=imola)
[![Codecov test coverage](https://codecov.io/gh/pedrocoutinhosilva/imola/branch/main/graph/badge.svg)](https://app.codecov.io/gh/pedrocoutinhosilva/imola?branch=main)
[![cranlogs](https://www.r-pkg.org/badges/version/imola)](https://CRAN.R-project.org/package=imola)
[![cranlogs](https://cranlogs.r-pkg.org/badges/imola)](https://CRAN.R-project.org/package=imola)
[![total](https://cranlogs.r-pkg.org/badges/grand-total/imola)](https://CRAN.R-project.org/package=imola)
<!-- badges: end -->

CSS Grid and flexbox layouts for R/Shiny

Imola (named after the first city ever to be given a technical blueprint by Leonardo da Vinci) aims at giving more layout creation options directly in R/shiny, without the hassle of having to create custom CSS every time.

---

### CSS Layouts in shiny, made simple
Leverage typical CSS layout techniques (grid and Flexbox) directly in your UI functions, including support for media breakpoints to fit different screen sizes and devices.

![](reference/figures/write-less.png)

---

### Use built in templates, or create your own
Save your favorite layouts for later use via the templating system and reuse them as many times as you need.

If layout creation isn't your thing, imola comes with a built in collection of templates for traditionally used web layouts, making it even easier to spice up your dashboards!

![](reference/figures/easy-templates.png)

Browse all available templates here: https://sparktuga.shinyapps.io/imolatemplates/

---

### Examples to get you started
Example applications showcasing some of the power of imola:

![](reference/figures/templatesdemo.png)
![](reference/figures/ua-tracker.png)

-   Usage examples: https://sparktuga.shinyapps.io/imola-examples/
-   Built in templates preview: https://sparktuga.shinyapps.io/imolatemplates/
-   UA Migration Tracker (Full code available): http://uaborder.com/

---

## installation
###### 1 - Install the package:

```R
# Install released version from CRAN
install.packages('imola')

# Or the most recent development version from github:
devtools::install_github('pedrocoutinhosilva/imola')
```

###### 2 - Include it in your project:
```R
# global.R
library(imola)
```
You are now ready to go!

Looking for help on how to start? Make sure to check the built in examples and vignettes for help and usage examples.

---

## Usage

Online documentation available at: https://www.anatomyofcode.com/imola

Check `vignette("imola")` on how to get started, and other follow up vignettes for even more information regarding CSS flexbox and grid and their imola equivalents.

Looking for a specific topic? Use the following vignettes for a quick start:

-   `vignette("imola-flexbox")` for details on `flexPanel()` and `flexPage()`.
-   `vignette("imola-grid")` for details on `gridPanel()` and `gridPage()`.
-   `vignette("imola-templates")` for information on using imola's templating engine.
-   `vignette("imola-breakpoints")` for information on using imola's breakpoint systems.
