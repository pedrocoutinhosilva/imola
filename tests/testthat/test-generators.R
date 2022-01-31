test_that("test generator functions", {
  # generateGridCSS
  expect_identical(
    generateGridCSS(list(areas = c("a", "b")), "test-id", c("a", "b"), getBreakpointSystem()),
    HTML(" .test-id > .a { grid-area: a; }  .test-id > .b { grid-area: b; }")
  )

  # generateGridAreaCSS
  expect_identical(
    generateGridAreaCSS(c("a", "b"), "test-id"),
    HTML(" .test-id > .a { grid-area: a; }  .test-id > .b { grid-area: b; }")
  )

  # generateFlexCSS
  expect_identical(
    generateFlexCSS(list(direction = list(default = "row")), "test-id", 2, getBreakpointSystem()),
    HTML(" #test-id { flex-direction: row; } ")
  )

  # generateFlexChildrenCSS
  expect_identical(
    generateFlexChildrenCSS(list(direction = list(default = "row", xs = "column")), "test-id", 1, getBreakpointSystem()),
    c("",
      " .test-id > *:nth-child(1) { flex-direction: row; }" ,
      " @media all  and (max-width: 575px)   .test-id > *:nth-child(1) { flex-direction: column; }"
    )
  )
  # generateCSSPropertyStyles
  expect_identical(
    generateCSSPropertyStyles(list(default = "value"), "property", "test-id", getBreakpointSystem()),
    c(" #test-id { property: value; }")
  )
})
