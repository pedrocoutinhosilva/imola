% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/breakpointSystems.R
\name{unregisterBreakpointSystem}
\alias{unregisterBreakpointSystem}
\title{Unregister a breakpoint system}
\usage{
unregisterBreakpointSystem(name)
}
\arguments{
\item{name}{A string with the name of a registered breakpoint system.
Registered systems are available
in \code{getOption("imola.breakpoint.systems")}.}
}
\value{
No return value, called for side effects.
}
\description{
Removes a globally registered breakpoint system from
\code{getOption("imola.breakpoint.systems")}.
}
\keyword{breakpoint_system}
\keyword{breakpoints}
