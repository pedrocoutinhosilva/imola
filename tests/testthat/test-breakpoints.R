test_that("test breakpoints functions", {
  # setActiveBreakpointSystem
  expect_identical(
    {
      setActiveBreakpointSystem("bulma")
      getOption("imola.breakpoints")[["bulma"]]
    },
    getOption("imola.mediarules")
  )

  # Return correct breakpoint system
  expect_identical(getBreakpointSystem(), getOption("imola.mediarules"))

  # registerBreakpoint
  registerBreakpoint("testbreak", min = 10000, max = 10001)
  expect_identical(getOption("imola.mediarules")$testbreak$min, 10000)
  expect_identical(getOption("imola.mediarules")$testbreak$max, 10001)

  # unregisterBreakpoint
  unregisterBreakpoint("testbreak")
  expect_identical(getOption("imola.mediarules")$testbreak, NULL)

  # cleanup
  setActiveBreakpointSystem("bootstrap3")
})
