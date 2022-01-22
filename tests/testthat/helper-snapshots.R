library(htmltools)
library(webshot2)

get_snapshot <- function(name, callback) {
  dir.create(paste0(tempdir(), "/snaptests"), recursive = TRUE, showWarnings = FALSE)

  path_html <- paste0(tempdir(), "/snaptests/", name, ".html")
  path_img <- paste0(tempdir(), "/snaptests/", name, ".png")

  htmltools::save_html(callback, path_html)
  webshot2::webshot(path_html, path_img, delay = 0.1, vwidth = 800, vheight = 600)

  path_img
}

test_grid_snapshots <- function(test_name, callback, ..., min_items = 1, max_items = 5) {
  lapply(seq.int(min_items, max_items), function(test_items) {
    name <- paste0(test_name, "-", test_items, "-items")

    items <- lapply(seq_len(test_items), function(i) {
      test_item()
    })

    expect_snapshot_file(get_snapshot(name,
      do.call(callback,  modifyList(items, list(...)))
    ))
  })
}
