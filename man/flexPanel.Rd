% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/flex.R
\name{flexPanel}
\alias{flexPanel}
\title{Create a css flexbox based HTML tag}
\usage{
flexPanel(
  ...,
  template = NULL,
  direction = "row",
  wrap = "nowrap",
  justify_content = "flex-start",
  align_items = "stretch",
  align_content = "flex-start",
  gap = 0,
  flex = c(1),
  grow = NULL,
  shrink = NULL,
  basis = NULL,
  breakpoint_system = getBreakpointSystem(),
  id = generateID()
)
}
\arguments{
\item{...}{Tag attributes (named arguments) and child elements (unnamed
arguments).

Named arguments are treated as additional html attribute
values to the parent tag.

Child elements may include any combination of other tags objects, \link{HTML}
strings, and \link{htmlDependency}s.}

\item{template}{The name of a registered template to use as a base for the
grid, or a template object from \link{gridTemplate}.}

\item{direction}{Direction of the flow of elements in the panel.

Accepts a valid css \code{flex-direction} value (\code{row} | \code{row-reverse} |
\code{column} | \code{column-reverse}).

Default value of \code{row} value is used. Supports breakpoints.}

\item{wrap}{Should elements be allowed to wrap into multiple lines.

Accepts a valid css \code{flex-wrap} value (\code{nowrap} | \code{wrap} | \code{wrap-reverse}).

Supports breakpoints.}

\item{justify_content}{The alignment along the main axis. Accepts a
valid css \code{justify-content} value (\code{flex-start} | \code{flex-end} | \code{center} |
\code{space-between} | \code{space-around} | \code{space-evenly} | \code{start} |
\code{end} | \code{left} | \code{right}).

Supports breakpoints.}

\item{align_items}{Defines the default behavior for how flex items are laid
out along the cross axis on the current line.

Accepts a valid css \code{align-items} value (\code{stretch} | \code{flex-start} |
\code{flex-end} | \code{center} | \code{baseline} | \verb{first baseline} | \verb{last baseline} |
\code{start} | \code{end} | \code{self-start} | \code{self-end}).

Supports breakpoints.}

\item{align_content}{Aligns a flex container’s lines within when there is
extra space in the cross-axis.

Accepts a valid css \code{align-content} value
(flex-start | flex-end | center | space-between | space-around |
space-evenly | stretch | start | end | baseline | first baseline |
last baseline).

Supports breakpoints.}

\item{gap}{The space between elements in the panel. Controls both the
space between rows and columns.

Accepts a css valid value, or 2 values separated by a space (if using
different values for row and column spacing).

Supports breakpoints.}

\item{flex}{A vector of valid css 'flex' values.
Defines how child elements in the panel can grow, shrink and their
initial size.

Arguments that target child elements require a vector of
values instead of a single value, with each entry of the vector affecting
the nth child element.

If the vector has less entries that the total number
of child elements, the values will be repeated until the pattern affects
all elements in the panel. If the vector as more entries that the
number of child elements, exceeding entries will be ignored. NA can also be
used as a entry to skip adding a rule to a specific child element.

Accepts a valid css \code{flex} value vector of values.

By default c(1) is used, meaning all elements can grow and shrink as
required, at the same rate. Supports breakpoints.}

\item{grow}{A vector of valid css 'flex-grow' values. Defines the rate of
how elements can grow.

Entries will overwrite the 'flex' values, and can
be used make more targeted rules.

Arguments that target child elements require a vector of
values instead of a single value, with each entry of the vector affecting
the nth child element.

If the vector has less entries that the total number
of child elements, the values will be repeated until the pattern affects
all elements in the panel. If the vector as more entries that the
number of child elements, exceeding entries will be ignored. NA can also be
used as a entry to skip adding a rule to a specific child element.

By default NULL is used, meaning values from the flex argument will be
used instead. Supports breakpoints.}

\item{shrink}{A vector of valid css 'flex-shrink' values. Defines the rate
of how elements can shrink. Entries will overwrite the nth 'flex' value,
and can be used make more targeted rules.

Arguments that target child elements require a vector of
values instead of a single value, with each entry of the vector affecting
the nth child element.

If the vector has less entries that the total number
of child elements, the values will be repeated until the pattern affects
all elements in the panel. If the vector as more entries that the
number of child elements, exceeding entries will be ignored. NA can also be
used as a entry to skip adding a rule to a specific child element.

By default NULL is used, meaning values from the flex argument will be
used instead. Supports breakpoints.}

\item{basis}{A vector of valid css 'flex-basis' values. Defines the base
size of elements. Entries will overwrite the nth 'flex' value,
and can be used make more targeted rules.

Arguments that target child elements require a vector of
values instead of a single value, with each entry of the vector affecting
the nth child element.

If the vector has less entries that the total number
of child elements, the values will be repeated until the pattern affects
all elements in the panel. If the vector as more entries that the
number of child elements, exceeding entries will be ignored. NA can also be
used as a entry to skip adding a rule to a specific child element.

By default NULL is used, meaning values from the flex argument will be
used instead. Supports breakpoints.}

\item{breakpoint_system}{Breakpoint system to use.}

\item{id}{The parent element id.}
}
\value{
An HTML \link{tagList}.
}
\description{
Creates a HTML tag and automatically generates css style rules based on css
flexbox, depending on the given arguments. Functionality acts as a way to
generate css flexbox based HTML containers directly from R without the need
to write any additional css rules directly.
}
\details{
Behaves similar to a normal HTML tag, but provides helping
arguments that simplify the way flexbox css can be created from shiny.
}
\note{
When creating responsive layouts based on css media rules, some
arguments allow a named list can be passed instead of a single value.

The names in that list can be any of the breakpoints available in
the \code{breakpoint_system} argument.

It is recommended to define the breakpoint system for the application
globally before UI definitions, but the \code{breakpoint_system} in panel
functions allows for more flexibility when reusing components
from other projects.

See \url{https://css-tricks.com/snippets/css/a-guide-to-flexbox/}
for additional details on using css flexbox.

For a full list of valid HTML attributes check visit
\url{https://www.w3schools.com/tags/ref_attributes.asp}.
}
\seealso{
\link{flexPage}
}
\concept{flexbox}
\keyword{flex}
\keyword{panel}
