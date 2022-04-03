test_that("test generator functions", {
  # generateGridCSS
  expect_identical(
    imola:::generateGridCSS(list(areas = c("a", "b")), "test-id", c("a", "b"), getBreakpointSystem("bootstrap3")),
    HTML(" .test-id > .a { grid-area: a; }  .test-id > .b { grid-area: b; }")
  )

  # generateGridAreaCSS
  expect_identical(
    imola:::generateGridAreaCSS(c("a", "b"), "test-id"),
    HTML(" .test-id > .a { grid-area: a; }  .test-id > .b { grid-area: b; }")
  )

  # generateFlexCSS
  expect_identical(
    imola:::generateFlexCSS(list(direction = list(default = "row")), "test-id", 2, getBreakpointSystem("bootstrap3")),
    HTML(" #test-id { flex-direction: row; } ")
  )

  # generateFlexChildrenCSS
  expect_identical(
    imola:::generateFlexChildrenCSS(list(direction = list(default = "row", xs = "column")), "test-id", 1, getBreakpointSystem("bootstrap3")),
    c("",
      " .test-id > *:nth-child(1) { flex-direction: row; }",
      " @media all  and (max-width: 575px)   .test-id > *:nth-child(1) { flex-direction: column; }"
    )
  )
  # generateCSSPropertyStyles
  expect_identical(
    imola:::generateCSSPropertyStyles(list(default = "value"), "property", "test-id", getBreakpointSystem("bootstrap3")),
    c(" #test-id { property: value; }")
  )
})
