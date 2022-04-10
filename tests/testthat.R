library(testthat)
library(magrittr)
library(rvest)
library(imola)

# You can manually skip all ui tests using the `skip_ui_tests` global option
# options(skip_ui_tests = TRUE)

start_time <- Sys.time()
test_check("imola")

print("Run time: ", Sys.time() - start_time)
