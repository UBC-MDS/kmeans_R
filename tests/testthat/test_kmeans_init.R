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

# initialize variables
set.seed(1234)
data_df <- data.frame(x = runif(100, min = 0, max = 10) + rep(c(0, 10), 50), y = rnorm(100, 5, 1) + rep(c(0, 10), 50))

cluster_borders <- list('x' = quantile(data_df$x, probs = c(0, 0.5, 1)),
                        'y' = quantile(data_df$y, probs = c(0, 0.5, 1)))

init_vals <- kmeans_init(data = data_df, K = 2)

test_that("test for correct error handling if no data object is given as input", {
  expect_error(kmeans_init(data = NULL),
               "Data object is missing or in the wrong format. Make sure you input a matrix or data frame data object")
})

test_that("test for correct error handling if no K value is given as input", {
  expect_error(kmeans_init(data = data.frame(), K = NULL),
               "K value is missing or not a numeric integer. Please specify the number of initial values/seeds as an integer.")
})

test_that("test for correct error handling if K value is given that is larger than the number of data rows", {
  expect_error(kmeans_init(data = data_df, K = nrow(data_df) + 1),
               "Cannot generate more initializing values than available data points. Please select a K value smaller than the number of observations.")
})

test_that("test for correct error handling if invalid method is given as input", {
  expect_error(kmeans_init(data = data_df, K = 2, method = "blah"),
               "Please choose a valid method or revert to default.")
})

test_that("test that no rows are returned where empty data object is given as input with zero K value", {
  expect_equal(nrow(kmeans_init(data = data.frame(), K = 0)), 0)
})

test_that("test that no columns are returned where empty data object is given as input with zero K value", {
  expect_equal(ncol(kmeans_init(data = data.frame(), K = 0)), 0)
})

test_that("test if returned object is matrix given valid input", {
  expect_equal(is.matrix(kmeans_init(data = data_df,
                          K = 2)), TRUE)
})

test_that("test if returned object has same number of rows as input K value", {
  expect_equal(nrow(kmeans_init(data = data_df,
                          K = 2)), 2)
})

test_that("test if returned object has same number of columns as input data object", {
  expect_equal(ncol(kmeans_init(data = data_df,
                          K = 2)), 2)
})


test_that("test if initialization values fall within the logical clusters", {

 expect_equal(all(c(min(init_vals[ ,1]) >= cluster_borders$x[1],
                min(init_vals[ ,1]) <= cluster_borders$x[2])), TRUE)

 expect_equal(all(c(max(init_vals[ ,1]) >= cluster_borders$x[2],
                max(init_vals[ ,1]) <= cluster_borders$x[3])), TRUE)

 expect_equal(all(min(init_vals[ ,2]) >= cluster_borders$y[1],
                min(init_vals[ ,2]) <= cluster_borders$y[2]), TRUE)

 expect_equal(all(max(init_vals[ ,2]) >= cluster_borders$y[2],
                max(init_vals[ ,2]) <= cluster_borders$y[3]), TRUE)

})

test_that("test for correct error handling if invalid seed is provided", {
  expect_error(kmeans_init(data = data_df,
                          K = 2, method = "rp", seed = 12.12), "Invalid seed has been provided. Please specify seed as integer or omit.")
})

test_that("test if same seed gives same result", {
  expect_equal(identical(kmeans_init(data = data_df,
                          K = 2, method = "rp", seed = 1234), kmeans_init(data = data_df,
                          K = 2, method = "rp", seed = 1234)), TRUE)
})

test_that("test if different seeds give different results", {
  expect_equal(identical(kmeans_init(data = data_df,
                          K = 2, method = "rp", seed = 1234), kmeans_init(data = data_df,
                          K = 2, method = "rp", seed = 2)), FALSE)
})

