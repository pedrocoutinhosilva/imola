test_that("listTemplates retuns all available templates", {
  expect_snapshot(listTemplates())
})

test_that("listTemplates retuns all available flex templates", {
  expect_snapshot(listTemplates("flex"))
})

test_that("listTemplates retuns all available grid templates", {
  expect_snapshot(listTemplates("grid"))
})

test_that("registerTemplate registers a new template in the options", {
  expect_snapshot({
    registerTemplate("flex", "test-template", direction = "row")
    listTemplates("flex")$`test-template`
  })
})

test_that("makeTemplate retuns a valid template object", {
  expect_snapshot(makeTemplate("flex", direction = "row"))
})

test_that("makeTemplate exports a fiel template when requested", {
  expect_true({
    makeTemplate("flex", direction = "row", export = paste0(tempdir(), "/test.yaml"))
    file.exists(paste0(tempdir(), "/test.yaml"))
  })
})

test_that("unregisterTemplate unregisters a template successfully", {
  expect_equal(
    {
      unregisterTemplate("flex", "test-template")
      listTemplates("flex")$`test-template`
    },
    NULL
  )
})

test_that("applyTemplate applies an existing template sucessully to a list of attributes", {
  expect_snapshot(applyTemplate(list(), "two-three-alternate", list(), "flex"))
})

test_that("applyTemplate applies an existing template sucessully using default values when needed", {
  expect_snapshot(applyTemplate(list(), makeTemplate("flex", direction = "row"), list(direction = "column"), "flex"))
})

test_that("applyTemplate errors out correctly", {
  expect_error(applyTemplate(list(), "two-three-alternate", list(), "grid"))
  expect_error(applyTemplate(list(), "error-template", list(), "flex"))
  expect_error(applyTemplate(list(), makeTemplate("flex", direction = "row"), list(direction = "column"), "grid"))
})
