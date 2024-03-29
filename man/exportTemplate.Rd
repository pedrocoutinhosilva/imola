% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/templates.R
\name{exportTemplate}
\alias{exportTemplate}
\title{Export a template}
\usage{
exportTemplate(template, path)
}
\arguments{
\item{template}{A template
object generated with \link{gridTemplate}.}

\item{path}{The file path where to export the system to, including the file
name and extension. The file name must end with a \code{.yaml} extension.}
}
\value{
No return value, called for side effects.
}
\description{
Exports a template into a file for storage and later usage.
Exported template can be retrieved from their file form by using
\link{importTemplate}.
}
\keyword{templates}
