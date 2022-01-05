library(shiny)
library(shiny.fluent)
library(imola)

shinyApp(
  ui = ActivityItem(
    activityDescription = tagList(
      Link(key = 1, "Philippe Lampros"),
      tags$span(key = 2, " commented")
    ),
    activityIcon = Icon(iconName = "Message"),
    comments = gridPanel(
      columns = c("2fr", "1fr"),
      rows = c("1fr", "1fr"),
      tags$span(key = 1, "Hello! I am making a comment."),
      tags$span(key = 2, "Hello! I am making a comment 2."),
      tags$span(key = 3, "Hello! I am making a comment 3."),
      tags$span(key = 4, "Hello! I am making a comment 4.")
    ),
    timeStamp = "Just now"
  ),
  server = function(input, output) {}
)
