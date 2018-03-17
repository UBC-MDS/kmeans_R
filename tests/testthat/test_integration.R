# Kmeans integration tests
#
# Testing includes:
#  - pair wise testing fo init, cluster, and report
#  - end to end test

library(kmeansR)
context("kmeans integration")

set.seed(42)
synth_data <- data.frame(
  x = c(rnorm(20,1,1), rnorm(30,6,3), rnorm(15,10,2)),
  y = c(rnorm(20,5,2), rnorm(30,2,2), rnorm(15,8,3))
)

test_that("End to end integration works.", {
  centers <- kmeans_init(data= synth_data, K = 3)
  clustered_data <- kmeans_cluster(data = synth_data, centers = centers)
  report <- kmeans_report(clustered_data=clustered_data)
  expect_equal(
    is.list(report), TRUE
  )
})

test_that("Init and cluster work together", {
  centers <- kmeans_init(data= synth_data, K = 3)
  clustered_data <- kmeans_cluster(data = synth_data, centers = centers)
  expect_equal(ncol(clustered_data), ncol(synth_data) + 1)
})

test_that("Cluster and report work together", {
  centers <- data.frame(x = c(1,5), y = c(2,-5))
  clustered_data <- kmeans_cluster(data = synth_data, centers = centers)
  report <- kmeans_report(clustered_data=clustered_data)
  expect_equal(
    is.list(report), TRUE
  )
})
