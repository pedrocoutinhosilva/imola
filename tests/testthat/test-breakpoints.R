test_that("Breakpoint system from from settings", {
  expect_identical(
    getBreakpointSystem("bulma"),
    getOption("imola.breakpoint.systems")[["bulma"]]
  )
})

test_that("Breakpoint creation", {
  expect_error(breakpoint("empty"))
  expect_snapshot(breakpoint("breakpoint_min_only", min = 999))
  expect_snapshot(breakpoint("breakpoint_max_only", max = 1000))
  expect_snapshot(breakpoint("breakpoint_min_max", min = 999, max = 1000))
})

test_that("Breakpoint system creation", {
  expect_error(breakpointSystem("empty"))

  expect_snapshot(breakpointSystem(
    "single_breakpoint",
    breakpoint("breakpoint_max_only", max = 1000),
    breakpoint("breakpoint_min_max", min = 999, max = 1000)
  ))

  expect_snapshot(breakpointSystem(
    "multiple_breakpoints",
    breakpoint("breakpoint_max_only", max = 1000),
    breakpoint("breakpoint_min_max", min = 999, max = 1000)
  ))
})

test_that("Breakpoint add removal", {
  system <- breakpointSystem(
    "single_breakpoint",
    breakpoint("breakpoint_max_only", max = 1000),
    breakpoint("breakpoint_min_max", min = 999, max = 1000)
  )

  system <- addBreakpoint(system, breakpoint("new", min = 999, max = 1000))
  expect_true(length(system$breakpoints) == 3)
  expect_snapshot(system)

  system <- removeBreakpoint(system, "new")
  expect_true(length(system$breakpoints) == 2)
  expect_snapshot(system)
})

test_that("Breakpoint system import and export", {
  test_system <- getBreakpointSystem("bulma")
  test_path <- tempfile(fileext = ".yaml")

  expect_message(exportBreakpointSystem(test_system, test_path))
  expect_true(file.exists(test_path))

  expect_identical(importBreakpointSystem(test_path), test_system)
})

test_that("Breakpoint system import and export from string", {
  test_system <- "bulma"
  test_path <- tempfile(fileext = ".yaml")

  expect_message(exportBreakpointSystem(test_system, test_path))
  expect_true(file.exists(test_path))

  expect_identical(
    importBreakpointSystem(test_path),
    getBreakpointSystem(test_system)
  )
})

test_that("List breakpoint systems", {
  expect_identical(
    listBreakpointSystems(),
    getOption("imola.breakpoint.systems")
  )
  expect_snapshot(listBreakpointSystems())
})

test_that("Register breakpoint systems", {
  system <- breakpointSystem(
    "test_system",
    breakpoint("breakpoint_max_only", max = 1000),
    breakpoint("breakpoint_min_max", min = 999, max = 1000)
  )
  suppressMessages({
    registerBreakpointSystem(system)
  })
  expect_identical(
    system,
    getOption("imola.breakpoint.systems")[["test_system"]]
  )
  expect_snapshot(listBreakpointSystems())

  unregisterBreakpointSystem("test_system")
  expect_identical(
    NULL,
    getOption("imola.breakpoint.systems")[["test_system"]]
  )
  expect_snapshot(listBreakpointSystems())
})

test_that("Setting active breakpoint system", {
  setActiveBreakpointSystem("bulma")
  expect_snapshot(getBreakpointSystem())
  expect_identical(getBreakpointSystem(), getBreakpointSystem("bulma"))
})

test_that("Setting active breakpoint system from a system object", {
  system <- breakpointSystem(
    "single_breakpoint",
    breakpoint("breakpoint_max_only", max = 1000),
    breakpoint("breakpoint_min_max", min = 999, max = 1000)
  )

  setActiveBreakpointSystem(system)
  expect_snapshot(getBreakpointSystem())
  expect_identical(getBreakpointSystem(), system)
})

test_that("Reset active breakpoint system", {
  setActiveBreakpointSystem("bootstrap3")
  expect_snapshot(getBreakpointSystem())
})
