# Requirements
The test battery includes unit, snapshot and UI testing. To run all tests make sure to include all packages in the `suggests` section of the DESCRIPTION file:

```
testthat (>= 3.0.0),
rvest,
devtools,
webshot2,
covr
```

# Running tests
Tests can be run using `devtools`
```
devtools::test()
```

Because of the slow nature of UI tests, you might want to disable these for quick testing during development. You can disable them for your current session by setting the global `skip_ui_tests` option using
```
options(skip_ui_tests = TRUE)
```

# Test Coverage
Coverage is aimed to be 100% whenever possible. You can check the current coverage report using one of the following:
```
devtools::test_coverage()
covr::code_coverage()
covr::report()
```
