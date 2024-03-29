% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{processContent}
\alias{processContent}
\title{Process HTML content}
\usage{
processContent(content, areas)
}
\arguments{
\item{content}{A (named) list of HTML elements.}

\item{areas}{The names in content that should have a class added.}
}
\value{
A list of HTML elements.
}
\description{
Adds a css class to any HTML elements from the content that are named and
which name is in the areas vector for names. This allows content to be
assigned to the grid areas via named argument while still allowing other
generic HTML tag attributes to be used.
}
\keyword{internal}
\keyword{utils}
