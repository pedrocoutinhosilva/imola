library(htmltools)
library(webshot2)

# Generates a png snapshot of a callback that returns a html tag list.
snapshot <- function(name,
                     callback,
                     location = paste0(tempdir(), "/snaptests/"),
                     vwidth = 800,
                     vheight = 600) {
  dir.create(location, recursive = TRUE, showWarnings = FALSE)

  path_html <- paste0(location, name, ".html")
  path_img <- paste0(location, name, ".png")

  htmltools::save_html(callback, path_html)
  webshot2::webshot(
    path_html,
    path_img,
    delay = 0.1,
    vwidth = vwidth,
    vheight = vheight
  )

  path_img
}

# Tests a set of arguments for a grid/flex callback for
# multiple number fo child elements
test_snapshots <- function(test_name,
                           callback,
                           ...,
                           min_items = 1,
                           max_items = 5,
                           vwidth = 800,
                           vheight = 600) {
  lapply(seq.int(min_items, max_items), function(test_items) {
    name <- paste0(test_name, "-", test_items, "-items")

    items <- lapply(seq_len(test_items), function(i) {
      test_item(i)
    })

    expect_snapshot_file(snapshot(name,
      do.call(callback,  modifyList(items, list(...))),
      vwidth = vwidth,
      vheight = vheight
    ))
  })
}
