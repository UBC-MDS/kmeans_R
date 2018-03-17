# Kmeans clustering tests
#
# Testing includes:
#  - graceful failure when handed null data
#  - correctly clusters toy example
#  - checks that returns object of type list
#  - checks that the list contains the original data
#  - checks that the list contains the cluster assignments
#  - checks that warning is thrown when fails to converge

library(kmeansR)
context("kmeans clustering")

synth_data <- data.frame(x = c(1,5,1),
                         y = c(2,-5,2),
                         z = c(3,0,3))

synth_centers <- data.frame(x = c(1,5),
                            y = c(2,-5),
                            z = c(3,0))


test_that("Correct error is thrown in the absence of data", {
  expect_error(kmeans_cluster(data = NULL, centers=synth_centers),
               "Data object is missing or in the wrong format.")
})


test_that("Correct error is thrown in the absence of centers", {
  expect_error(kmeans_cluster(data = synth_data,
                              centers=NULL),
               "Centers object is missing or in the wrong format.")
})

test_that("Correct error is thrown when data and centers are incomp. shape", {
  expect_error(kmeans_cluster(data = synth_data,
                              centers=synth_centers[,c("x","y")]),
               "Data and centers are incompatible shape.")
})


test_that("test that we are actually getting a list", {
  expect_equal(
    is.data.frame(
      kmeans_cluster(data = synth_data, centers = synth_centers)),
    TRUE)
})


test_that("The data frame returned has correct shape", {
  expect_equal(
    nrow(kmeans_cluster(data = synth_data, centers = synth_centers)),
    nrow(synth_data))

  expect_equal(
    ncol(kmeans_cluster(data = synth_data, centers = synth_centers)),
    ncol(synth_data) + 1)
})


test_that("Example where the resulting assignments can be computed by hand", {
  expect_equal(
    kmeans_cluster(data = synth_data, centers = synth_centers)$cluster,
    c(1,2,1))
})


test_that("When we exceed maximum number of iterations", {
  expect_warning(
    kmeans_cluster(data = synth_data,
                   centers = synth_centers,
                   max_iter=1),
    "Did not converge in specified number of iterations")
})
