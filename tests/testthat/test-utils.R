test_that("generateID generates valid ID strings", {
  expect_equal(is.character(imola:::generateID()), TRUE)
  expect_match(imola:::generateID(), "grid_")
})

test_that("stringTemplate generates valid strings", {
  expect_equal(imola:::stringTemplate("test"), "test")
  expect_equal(
    imola:::stringTemplate("test_{{argument}}", argument = "value"),
    "test_value"
  )
})

test_that("stringCSSRule generates valid strings", {
  expect_equal(
    imola:::stringCSSRule("generated_id", id = "test_id"),
    "grid_test_id"
  )
})

test_that("processContent works when no areas are given", {
  expect_snapshot(
    imola:::processContent(list(`area-1` = div(), `area-2` = div()), NULL)
  )
})

test_that("processContent works when no areas are empty", {
  expect_snapshot(
    imola:::processContent(list(`area-1` = div(), `area-2` = div()), c())
  )
})

test_that("processContent works when only some areas are given", {
  expect_snapshot(
    imola:::processContent(
      list(`area-1` = div(), `area-2` = div()), c("area-1")
    )
  )
})

test_that("processContent works when only all areas are given", {
  expect_snapshot(
    imola:::processContent(
      list(`area-1` = div(), `area-2` = div()), c("area-1", "area-2")
    )
  )
})

test_that("valueToCSS are converted correctly to valid css strings", {
  expect_equal(imola:::valueToCSS("value", "property"), "value")
  expect_equal(imola:::valueToCSS(c("foo", "bar"), "property"), "foo bar")
})

test_that("mediaRuleTemplate generates rules for different min max values", {
  expect_equal(
    imola:::mediaRuleTemplate(list(min = 0, max = 1)),
    " @media all and (min-width: 0px)  and (max-width: 1px)  { {{rules}} }"
  )
  expect_equal(
    imola:::mediaRuleTemplate(list(min = 0)),
    " @media all and (min-width: 0px)   { {{rules}} }"
  )
  expect_equal(
    imola:::mediaRuleTemplate(list(max = 1)),
    " @media all  and (max-width: 1px)  { {{rules}} }"
  )
})

test_that("readSettingsFile loads a file successfully", {
  expect_snapshot(imola:::readSettingsFile("config"))
})
