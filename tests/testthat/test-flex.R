# TODO: flex = c(1),
# TODO: grow = NULL,
# TODO: shrink = NULL,
# TODO: basis = NULL,

# Tests for default retuns
test_that("Base tests", {
  # Node is generated
  expect_length(flexPage() %>% find_html_node("div"), 1)
  expect_length(flexPanel() %>% find_html_node("div"), 1)
})

# Tests for the ... argument
test_that("Test ...", {
  # html is generated with child html
  expect_match(flexPanel(div(id = "test-child")) %>% toString(), "<div id=\"test-child\"></div>")
  expect_match(flexPanel(div(id = "test-child"), div(id = "test-child2")) %>% toString(), "<div id=\"test-child\"></div>\n  <div id=\"test-child2\">")

  # html attributes get added using ...
  expect_match(flexPanel(`data-attribute` = "test-value") %>% toString(), "data-attribute=\"test-value\"")
})

# Tests for the title argument
test_that("Test title", {
  # title is added
  expect_length(flexPage(title = "test title") %>% htmltools::doRenderTags() %>% find_html_node("title"), 1)
  expect_match(flexPage(title = "test title") %>% htmltools::doRenderTags() %>% toString(), "<title>test title</title>")

  # no title is added if none provided
  expect_length(flexPage() %>% htmltools::doRenderTags() %>% find_html_node("title"), 0)
  expect_no_match(flexPage() %>% htmltools::doRenderTags() %>% toString(), "<title></title>")
})

# Tests for the id argument
test_that("Test Ids", {
  # Test if default ids are used
  expect_length(flexPage() %>% find_html_node("#grid-page-wrapper"), 1)
  expect_match(
    flexPanel() %>% find_html_node("div") %>% rvest::html_attr("id"),
    "grid_"
  )

  # Given id is used
  expect_error(gridPage(id = "test-id"))
  expect_length(gridPanel(id = "test-id") %>% find_html_node("#test-id"), 1)
})

# Tests for the gap argument
test_that("Test gap", {
  # css is generated
  # string syntax
  expect_match(flexPanel(gap = "10px") %>% toString(), "gap: 10px")
  expect_match(flexPage(gap = "10px") %>% toString(), "gap: 10px")
  expect_match(flexPanel(gap = "10px 20px") %>% toString(), "gap: 10px 20px")
  expect_match(flexPage(gap = "10px 20px") %>% toString(), "gap: 10px 20px")

  # vector syntax
  expect_match(flexPanel(gap = c("10px")) %>% toString(), "gap: 10px")
  expect_match(flexPage(gap = c("10px")) %>% toString(), "gap: 10px")
  expect_match(flexPanel(gap = c("10px", "20px")) %>% toString(), "gap: 10px 20px")
  expect_match(flexPage(gap = c("10px", "20px")) %>% toString(), "gap: 10px 20px")
})

# Test cases to test
test_cases <- list(
  direction = list(
    `row` = "row",
    `row-reverse` = "row-reverse",
    `column` = "column",
    `column-reverse` = "column-reverse"
  ),

  wrap = list(
    `nowrap` = "nowrap",
    `wrap` = "wrap",
    `wrap-reverse` = "wrap-reverse"
  ),

  justify_content = list(
    `flex-start` = "flex-start",
    `flex-end` = "flex-end",
    `center` = "center",
    `space-between` = "space-between",
    `space-around` = "space-around",
    `space-evenly` = "space-evenly"
  ),

  align_items = list(
    `stretch` = "stretch",
    `flex-start` = "flex-start",
    `flex-end` = "flex-end",
    `center` = "center",
    `start` = "start",
    `end` = "end"
  ),

  align_content = list(
    `flex-start` = "flex-start",
    `flex-end` = "flex-end",
    `center` = "center",
    `space-between` = "space-between",
    `space-around` = "space-around",
    `space-evenly` = "space-evenly"
  )
)

# Tests for the gap argument
test_that("Test positionings", {
  lapply(names(test_cases$direction), function(case) {
    expect_match(flexPanel(direction = test_cases$direction[[case]]) %>% toString(), paste0("direction: ", test_cases$direction[[case]]))
  })
  lapply(names(test_cases$wrap), function(case) {
    expect_match(flexPanel(wrap = test_cases$wrap[[case]]) %>% toString(), paste0("wrap: ", test_cases$wrap[[case]]))
  })
  lapply(names(test_cases$justify_content), function(case) {
    expect_match(flexPanel(justify_content = test_cases$justify_content[[case]]) %>% toString(), paste0("justify-content: ", test_cases$justify_content[[case]]))
  })
  lapply(names(test_cases$align_items), function(case) {
    expect_match(flexPanel(align_items = test_cases$align_items[[case]]) %>% toString(), paste0("align-items: ", test_cases$align_items[[case]]))
  })
  lapply(names(test_cases$align_content), function(case) {
    expect_match(flexPanel(align_content = test_cases$align_content[[case]]) %>% toString(), paste0("align-content: ", test_cases$align_content[[case]]))
  })
})

# UI tests for multiple arguments
test_that("UI generation tests", {
  skip_on_ci()
  skip_on_covr()

  # Tests empty grids
  test_snapshots("flexPanel-empty", flexPanel, min_items = 0, max_items = 0)
  test_snapshots("flexPage-empty", flexPage, min_items = 0, max_items = 0)

  # Tests all column test cases
  lapply(names(test_cases$direction), function(case) {
    test_snapshots(
      paste0("flexPanel-", case),
      flexPanel,
      direction = test_cases$direction[[case]]
    )
  })

  lapply(names(test_cases$wrap), function(case) {
    test_snapshots(
      paste0("flexPanel-", case),
      flexPanel,
      wrap = test_cases$wrap[[case]]
    )
  })

  lapply(names(test_cases$justify_content), function(case) {
    test_snapshots(
      paste0("flexPanel-", case),
      flexPanel,
      justify_content = test_cases$justify_content[[case]]
    )
  })

  lapply(names(test_cases$align_items), function(case) {
    test_snapshots(
      paste0("flexPanel-", case),
      flexPanel,
      align_items = test_cases$align_items[[case]]
    )
  })

  lapply(names(test_cases$align_content), function(case) {
    test_snapshots(
      paste0("flexPanel-", case),
      flexPanel,
      align_content = test_cases$align_content[[case]]
    )
  })
})
