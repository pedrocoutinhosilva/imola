test_that("UI generation tests", {
  test_cases <- list(
    columns = list(
      `two-columns-string` = "1fr 1fr",
      `two-columns-vector` = c("1fr", "1fr"),
      `three-columns-string` = "100px 1fr 2fr",
      `three-columns-vector` = c("100px", "1fr", "2fr"),
      `columns-mixed-units` = "100px 1fr 50%"
    ),

    rows = list(
      `two-rows-string` = "1fr 1fr",
      `two-rows-vector` = c("1fr", "1fr"),
      `three-rows-string` = "100px 1fr 2fr",
      `three-rows-vector` = c("100px", "1fr", "2fr"),
      `rows-mixed-units` = "100px 1fr 50"
    )
  )

  # empty grid
  test_grid_snapshots("gridPanel-empty", gridPanel)

  lapply(names(test_cases$columns), function(case) {
    test_grid_snapshots(paste0("gridPanel-", case), gridPanel, columns = test_cases$columns[[case]])
  })

  lapply(names(test_cases$rows), function(case) {
    test_grid_snapshots(paste0("gridPanel-", case), gridPanel, columns = test_cases$rows[[case]])
  })

  lapply(names(test_cases$columns), function(case_columns) {
    lapply(names(test_cases$rows), function(case_rows) {
      test_grid_snapshots(paste0("gridPanel-", case_columns, "-", case_rows), gridPanel,
        rows = test_cases$rows[[case_rows]],
        columns = test_cases$columns[[case_columns]]
      )
    })
  })
})
