% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{stringCSSRule}
\alias{stringCSSRule}
\title{Evaluate a css template}
\usage{
stringCSSRule(template, ...)
}
\arguments{
\item{template}{The template name to use. Available templates are saved in
options, under \code{getOption("imola.settings")$string_templates}.}

\item{...}{Named arguments to use in the template string. All placeholders
in the template must have a corresponding named argument.}
}
\value{
A valid CSS string.
}
\description{
Applies a CSS statement template stored in the package settings. These
templates use the \link{htmlTemplate} format, meaning placeholders are marked
using the {{placeholder}} convention.
Each placeholder value should be passed as a named argument to the function
using the placeholder value as a name.
Used primarily as a shorthand to \link{stringTemplate} for stored templates.
}
\keyword{internal}
\keyword{utils}
