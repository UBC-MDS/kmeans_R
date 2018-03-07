# Kmeans initilization tests
#
# Testing includes:
#  - graceful failure when handed null data
#  - graceful failure when handed nullnumber of clusters
#  - defaults to 0 when no data and zero clusters are provided
#  - checks that returns object of type matrix
#  - checks that the dimension of returned matrix is correct

library(kmeansR)
context("kmeans initialization")

test_that("kmeans_init is a matrix of initialization coordinates", {
  expect_error(kmeans_init(data = NULL),
               "Data object is missing or in the wrong format. Make sure you input a matrix or data frame data object")
 expect_error(kmeans_init(data = data.frame(), K = NULL),
               "K value is missing or not a numeric integer. Please specify the number of initial values/seeds as an integer.")
 expect_equal(nrow(kmeans_init(data = data.frame(), K = 0)), 0)
 expect_equal(ncol(kmeans_init(data = data.frame(), K = 0)), 0)

 # the rest are expected to fail

 expect_equal(is.matrix(kmeans_init(data = data.frame(x = 1:3, y = 4:6, z = 1:3),
                          K = 2)), TRUE)
 expect_equal(nrow(kmeans_init(data = data.frame(x = 1:3, y = 4:6, z = 1:3),
                          K = 2)), 2)
 expect_equal(ncol(kmeans_init(data = data.frame(x = 1:3, y = 4:6, z = 1:3),
                          K = 2)), 3)

})
