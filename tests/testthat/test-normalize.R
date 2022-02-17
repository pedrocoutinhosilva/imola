test_that("Test normalize functions", {
  # String into normalized list
  expect_identical(
    imola:::normalizeAttribute("value"),
    list(default = list("value"))
  )

  # list into normalized list
  expect_identical(
    imola:::normalizeAttribute(list(name = "value")),
    list(name = list("value"))
  )

  # list into normalized list
  expect_identical(
    imola:::normalizeAttribute(list(name = "value", default = "default")),
    list(name = list("value"), default = list("default"))
  )

  # vector into normalized list
  expect_identical(
    imola:::normalizeAttribute(c("foo", "bar")),
    list(default = list("foo", "bar"))
  )

  # vector into normalized list
  expect_identical(
    imola:::normalizeAttribute(list("foo", "bar")),
    list(default = list("foo", "bar"))
  )

  # String into normalized list
  expect_identical(
    imola:::normalizeAttributes(
      list(
        `attribute-1` = "value",
        `attribute-2` = list(default = list("value"))
      )
    ),
    list(
      `attribute-1` = list(default = list("value")),
      `attribute-2` = list(default = list("value"))
    )
  )

  # list into normalized list
  expect_identical(
    imola:::normalizeAttributes(
      list(
        `attribute-1` = list(default = list("value")),
        `attribute-2` = list(default = list("value"))
      )
    ),
    list(
      `attribute-1` = list(default = list("value")),
      `attribute-2` = list(default = list("value"))
    )
  )

  # vector into normalized list
  expect_identical(
    imola:::normalizeAttributes(
      list(`attribute-1` = c("foo", "bar"), `attribute-2` = c("foo", "bar"))
    ),
    list(
      `attribute-1` = list(default = list("foo", "bar")),
      `attribute-2` = list(default = list("foo", "bar"))
    )
  )
})
