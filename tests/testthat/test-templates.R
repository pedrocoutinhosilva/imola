test_that("listTemplates retuns all available templates", {
  expect_snapshot(listTemplates())
})

test_that("listTemplates retuns all available flex templates", {
  expect_snapshot(listTemplates("flex"))
})

test_that("listTemplates retuns all available grid templates", {
  expect_snapshot(listTemplates("grid"))
})

test_that("Get a registered template", {
  expect_error(getTemplate("name", "wrong_type"))
  expect_error(getTemplate("non_existing_template", "grid"))

  expect_snapshot(getTemplate("holy-grail", "grid"))
})

test_that("Register a template", {
  expect_error(registerTemplate(list()))
  expect_snapshot({
    registerTemplate(gridTemplate("test-template", "flex", direction = "row"))
    listTemplates("flex")$`test-template`
  })
})

test_that("Export and import a template", {
  test_template <- gridTemplate("test-template", "flex", direction = "row")
  test_path <- tempfile(fileext = ".yaml")

  expect_message(exportTemplate(test_template, test_path))
  expect_true(file.exists(test_path))

  expect_identical(importTemplate(test_path), test_template)

  expect_error(exportTemplate(list(), NULL))
  expect_error(exportTemplate("error", NULL))
  expect_error(exportTemplate(NULL, NULL))
  expect_error(importTemplate())

  test_path_malformed <- tempfile(fileext = ".yaml")
  yaml::write_yaml(list(), test_path_malformed)
  expect_error(importTemplate(test_path_malformed))

  test_path_malformed_2 <- tempfile(fileext = ".yaml")
  yaml::write_yaml(
    list(name = "test"),
    test_path_malformed_2
  )
  expect_error(importTemplate(test_path_malformed_2))

  test_path_malformed_3 <- tempfile(fileext = ".yaml")
  yaml::write_yaml(
    list(name = "test", attributes = "value"),
    test_path_malformed_3
  )
  expect_error(importTemplate(test_path_malformed_3))
})

test_that("gridTemplate retuns a valid template object", {
  expect_snapshot(gridTemplate("test-template", "flex", direction = "row"))
})

test_that("gridTemplate exports a file template when requested", {
  expect_true({
    exportTemplate(
      gridTemplate("test-template", "flex", direction = "row"),
      paste0(tempdir(), "/test.yaml")
    )
    file.exists(paste0(tempdir(), "/test.yaml"))
  })
})

test_that("Unregister a template", {
  expect_warning(unregisterTemplate("no_template", "flex"))
  expect_equal(
    {
      unregisterTemplate("test-template", "flex")
      listTemplates("flex")$`test-template`
    },
    NULL
  )
})

test_that("Template applied to attribute list", {
  expect_snapshot(
    imola:::applyTemplate(list(), "two-three-alternate", list(), "flex")
  )
})

test_that("Template applied to attribute list with default values", {
  expect_snapshot(
    imola:::applyTemplate(
      list(),
      gridTemplate("test-template", "flex", direction = "row"),
      list(direction = "column"), "flex"
    )
  )
})

test_that("applyTemplate errors out when expected", {
  expect_error(
    imola:::applyTemplate(list(), "two-three-alternate", list(), "grid")
  )
  expect_error(
    imola:::applyTemplate(list(), "error-template", list(), "flex")
  )
  expect_error(
    imola:::applyTemplate(
      list(),
      gridTemplate("test-template", "flex", direction = "row"),
      list(direction = "column"), "grid"
    )
  )
})
