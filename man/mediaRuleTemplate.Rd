% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{mediaRuleTemplate}
\alias{mediaRuleTemplate}
\title{Create media rule template}
\usage{
mediaRuleTemplate(options)
}
\arguments{
\item{options}{The options for the required template. if no valid
values are given, a non media query template is created instead.}
}
\value{
A valid glue::glue template string to be processed later.
}
\description{
Creates a valid glue::glue string template for a css media query.
Used internally to generate a breakpoint specific wrapper.
}
\keyword{internal}
\keyword{utils}
