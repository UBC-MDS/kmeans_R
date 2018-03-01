library(kmeansR)
context("String length")

test_that("kmeans_init is a matrix of initialization coordinates", {
  expect_equal(kmeans_init(), NULL)
})
