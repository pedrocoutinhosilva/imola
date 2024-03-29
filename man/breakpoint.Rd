% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/breakpoints.R
\name{breakpoint}
\alias{breakpoint}
\title{Create a breakpoint}
\usage{
breakpoint(name, min = NULL, max = NULL)
}
\arguments{
\item{name}{A string with the name that identifies the breakpoint.}

\item{min}{Optional numeric minimum value (in pixels) of the screen width
where the breakpoint is active.}

\item{max}{Optional numeric maximum value (in pixels) of the screen width
where the breakpoint is active.}
}
\value{
A breakpoint object.
}
\description{
Creates a valid breakpoint object to use in a breakpoint system. While both
the min and max arguments are optional, at least one of them must exist for
the breakpoint to be considered valid.
}
\keyword{breakpoint}
\keyword{breakpoints}
