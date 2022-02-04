# Tests for default retuns
test_that("Base tests", {
  # Node is generated
  expect_length(gridPage() %>% find_html_node("div"), 1)
  expect_length(gridPanel() %>% find_html_node("div"), 1)
})

# Tests for the ... argument
test_that("Test ...", {
  # html is generated with child html
  expect_match(gridPanel(div(id = "test-child")) %>% toString(), "<div id=\"test-child\"></div>")
  expect_match(gridPanel(div(id = "test-child"), div(id = "test-child2")) %>% toString(), "<div id=\"test-child\"></div>\n  <div id=\"test-child2\">")


    # html attributes get added using ...
    expect_match(gridPanel(`data-attribute` = "test-value") %>% toString(), "data-attribute=\"test-value\"")
})

# Tests for the title argument
test_that("Test title", {
  # title is added
  expect_length(gridPage(title = "test title") %>% htmltools::doRenderTags() %>% find_html_node("title"), 1)
  expect_match(gridPage(title = "test title") %>% htmltools::doRenderTags() %>% toString(), "<title>test title</title>")

  # no title is added if none provided
  expect_length(gridPage() %>% htmltools::doRenderTags() %>% find_html_node("title"), 0)
  expect_no_match(gridPage() %>% htmltools::doRenderTags() %>% toString(), "<title></title>")
})

# Tests for the areas argument
test_that("Test areas", {
  # string syntax
  expect_match(gridPanel(areas = "areas1 area2") %>% toString(), "grid-template-areas: 'areas1 area2'")

  # vector syntax
  expect_match(gridPanel(areas = c("areas1 area2", "areas1 area2")) %>% toString(), "grid-template-areas: 'areas1 area2' 'areas1 area2'")

  # list syntax
  expect_match(gridPanel(areas = list(c("areas1", "area2"), c("areas1", "area2"))) %>% toString(), "grid-template-areas: 'areas1 area2' 'areas1 area2'")
})

# Tests for the rows argument
test_that("Test rows", {
  # css is generated
  # string syntax
  expect_match(gridPanel(rows = "1fr 1fr") %>% toString(), "grid-template-rows: 1fr 1fr")
  expect_match(gridPage(rows = "1fr 1fr") %>% toString(), "grid-template-rows: 1fr 1fr")

  # vector syntax
  expect_match(gridPanel(rows = c("1fr", "1fr")) %>% toString(), "grid-template-rows: 1fr 1fr")
  expect_match(gridPage(rows = c("1fr", "1fr")) %>% toString(), "grid-template-rows: 1fr 1fr")
})

# Tests for the columns argument
test_that("Test columns", {
  # css is generated
  # string syntax
  expect_match(gridPanel(columns = "1fr 1fr") %>% toString(), "grid-template-columns: 1fr 1fr")
  expect_match(gridPage(columns = "1fr 1fr") %>% toString(), "grid-template-columns: 1fr 1fr")

  # vector syntax
  expect_match(gridPanel(columns = c("1fr", "1fr")) %>% toString(), "grid-template-columns: 1fr 1fr")
  expect_match(gridPage(columns = c("1fr", "1fr")) %>% toString(), "grid-template-columns: 1fr 1fr")
})

# Tests for the gap argument
test_that("Test gap", {
  # css is generated
  # string syntax
  expect_match(gridPanel(gap = "10px") %>% toString(), "gap: 10px")
  expect_match(gridPage(gap = "10px") %>% toString(), "gap: 10px")
  expect_match(gridPanel(gap = "10px 20px") %>% toString(), "gap: 10px 20px")
  expect_match(gridPage(gap = "10px 20px") %>% toString(), "gap: 10px 20px")

  # vector syntax
  expect_match(gridPanel(gap = c("10px")) %>% toString(), "gap: 10px")
  expect_match(gridPage(gap = c("10px")) %>% toString(), "gap: 10px")
  expect_match(gridPanel(gap = c("10px", "20px")) %>% toString(), "gap: 10px 20px")
  expect_match(gridPage(gap = c("10px", "20px")) %>% toString(), "gap: 10px 20px")
})

# Tests for the align_items argument
test_that("Test align_items", {
  # css is generated
  # string syntax
  expect_match(gridPanel(align_items = "start") %>% toString(), "align-items: start")
  expect_match(gridPanel(align_items = "end") %>% toString(), "align-items: end")
  expect_match(gridPanel(align_items = "center") %>% toString(), "align-items: center")
  expect_match(gridPanel(align_items = "stretch") %>% toString(), "align-items: stretch")
})

# Tests for the justify_items argument
test_that("Test justify_items", {
  # css is generated
  # string syntax
  expect_match(gridPanel(justify_items = "start") %>% toString(), "justify-items: start")
  expect_match(gridPanel(justify_items = "end") %>% toString(), "justify-items: end")
  expect_match(gridPanel(justify_items = "center") %>% toString(), "justify-items: center")
  expect_match(gridPanel(justify_items = "stretch") %>% toString(), "justify-items: stretch")
})

# Tests for the auto_fill argument
test_that("Test auto_fill", {
  # css is generated
  # string syntax
  expect_match(gridPanel(id = "test-id", auto_fill = TRUE) %>% toString(), "#test-id \\{height: 100%;\\}")
  expect_no_match(gridPanel(id = "test-id", auto_fill = FALSE) %>% toString(), "#test-id \\{height: 100%;\\}")
})

# Tests for the id argument
test_that("Test Ids", {
  # Test if default ids are used
  expect_length(gridPage() %>% find_html_node("#grid-page-wrapper"), 1)
  expect_match(
    gridPanel() %>% find_html_node("div") %>% rvest::html_attr("id"),
    "grid_"
  )

  # Given id is used
  expect_error(gridPage(id = "test-id"))
  expect_length(gridPanel(id = "test-id") %>% find_html_node("#test-id"), 1)
})

# UI tests for multiple arguments
test_that("UI generation tests", {
  skip_on_ci()
  skip_on_covr()
  skip_if(getOption("skip_ui_tests"), message = "Skip UI tests")

  # Values for test cases to be reused in multiple tests
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
    ),

    gap = list(
      `no-gap` = NULL,
      `pixel-gap` = "10px",
      `pixel-double-gap` = c("10px", "20px"),
      `pixel-double-gap-string` = "10px 20px",
      `percent-gap` = "10%",
      `percent-double-gap` = "10% 20%"
    ),

    align_items = list(
      start = "start",
      end = "end",
      center = "center",
      stretch = "stretch"
    ),

    justify_items = list(
      start = "start",
      end = "end",
      center = "center",
      stretch = "stretch"
    )
  )

  # Tests empty grids
  test_snapshots("gridPanel-empty", gridPanel, min_items = 0, max_items = 0)
  test_snapshots("gridPage-empty", gridPage, min_items = 0, max_items = 0)

  # Tests all column test cases
  lapply(names(test_cases$columns), function(case) {
    test_snapshots(
      paste0("gridPanel-", case),
      gridPanel,
      columns = test_cases$columns[[case]]
    )
  })

  # Tests all rows test cases
  lapply(names(test_cases$rows), function(case) {
    test_snapshots(
      paste0("gridPanel-", case),
      gridPanel,
      rows = test_cases$rows[[case]]
    )
  })

  # Tests all gap test cases
  lapply(names(test_cases$gap), function(case) {
    test_snapshots(
      paste0("gridPanel-", case),
      gridPanel,
      gap = test_cases$gap[[case]]
    )
  })

  # Tests combinations of columns rows gaps test cases
  lapply(names(test_cases$gap), function(case_gap) {
    case_rows <- "three-rows-string"
    case_columns <- "three-columns-string"

    test_snapshots(
      paste0("gridPanel-", case_columns, "-", case_rows, "-", case_gap),
      gridPanel,
      rows = test_cases$rows[[case_rows]],
      columns = test_cases$columns[[case_columns]],
      gap = test_cases$gap[[case_gap]]
    )
  })
})
