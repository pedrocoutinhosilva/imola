test_that("Breakpoint system extracted from settings", {
  expect_identical(
    getBreakpointSystem("bulma"),
    getOption("imola.breakpoint.systems")[["bulma"]]
  )
})

test_that("Breakpoint system saved and loaded correctly to file", {
  test_system <- getBreakpointSystem("bulma")
  test_path <- tempfile(fileext = ".yaml")

  expect_message(exportBreakpointSystem(test_system, test_path))
  expect_identical(importBreakpointSystem(test_path), test_system)
})

test_that("Breakpoint system creation", {
  breakpointSystem(
    "test-system"
  )
})



# test_that("test breakpoints functions", {
#   expect_identical(
#     {
#       getBreakpointSystem("bulma")
#       getOption("imola.breakpoint.systems")[["bulma"]]
#     },
#     getOption("imola.mediarules")
#   )
#
#   expect_identical(
#     {
#       setActiveBreakpointSystem("bulma")
#       getOption("imola.breakpoint.systems")[["bulma"]]
#     },
#     getOption("imola.mediarules")
#   )
#
#   # Return correct default breakpoint system
#   expect_identical(getBreakpointSystem(), getOption("imola.mediarules"))
#
#   # registerBreakpoint
#   registerBreakpoint("testbreak", min = 10000, max = 10001)
#   expect_identical(getOption("imola.mediarules")$testbreak$min, 10000)
#   expect_identical(getOption("imola.mediarules")$testbreak$max, 10001)
#
#   # unregisterBreakpoint
#   unregisterBreakpoint("testbreak")
#   expect_identical(getOption("imola.mediarules")$testbreak, NULL)
#
#   # cleanup
#   setActiveBreakpointSystem("bootstrap3")
# })
