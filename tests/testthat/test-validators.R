test_that("Test breakpoint validators", {
  expect_true(is.breakpoint(breakpoint("breakpoint_true", min = 999)))
  expect_true(!(imola:::is.breakpoint("string")))
  expect_true(!(imola:::is.breakpoint(123)))
  expect_true(!(imola:::is.breakpoint(c())))
  expect_true(!(imola:::is.breakpoint(list())))
})

test_that("Test breakpoint system validators", {
  system <- breakpointSystem(
    "single_breakpoint",
    breakpoint("breakpoint_max_only", max = 1000)
  )

  expect_true(is.breakpointSystem(system))
  expect_true(!(imola:::is.breakpointSystem("string")))
  expect_true(!(imola:::is.breakpointSystem(123)))
  expect_true(!(imola:::is.breakpointSystem(c())))
  expect_true(!(imola:::is.breakpointSystem(list())))
})

test_that("Test template validators", {
  expect_true(
    is.template(gridTemplate("test-template", "flex", direction = "row"))
  )
  expect_true(!(imola:::is.template("string")))
  expect_true(!(imola:::is.template(123)))
  expect_true(!(imola:::is.template(c())))
  expect_true(!(imola:::is.template(list())))
})
