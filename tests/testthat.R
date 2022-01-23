library(testthat)
library(magrittr)
library(rvest)
library(imola)

start_time <- Sys.time()
test_check("imola")

print("Run time: ", Sys.time() - start_time)
