# Kmeans plot tests
#
# Testing includes:
#  - graceful failure when handed null data
#  - graceful failure when cluster assignments are missing
#  - checks that a plot file is actually produced and saved

library(kmeansR)
context("report kmeans findings")

test_that("kmeans_plot successfully plots the data and cluster assignments", {

  # test that the correct error is thrown in the absence of data
  expect_error(kmeans_report(data = NULL),
               "Data object is missing or in the wrong format.")

  # test that the correct error is thrown in the absense of cluster assignemnts
  expect_error(kmeans_report(data = data.frame(), clust_assigns = NULL),
               "Cluster assignements are in the wrong format.")

  # test that correct error is thrown when data & cluster assignments are different lengths
  expect_error(kmeans_report(data = data.frame(x = c(1,5,1),
                                               y = c(2,-5,2),
                                               z = c(3,0,3)),
                             clust_assigns = data.frame(x = c(1),
                                                        y = c(2))),
               "Data and cluster assignmenments must be the same length!")

  # test that the output is a list ()
  expect_equal(
    is.list(
    kmeans_report(data = data.frame(x = c(1,5,1),
                                    y = c(2,-5,2),
                                    z = c(3,0,3)),
                  clust_assigns = data.frame(x = c(1,2,3)))),
               TRUE)

  # check that a plot is produced for 2 dimensional data
  expect_equal(
    is.ggplot(
      kmeans_report(data = data.frame(x = c(1,5),
                                      y = c(2,-5)),
                    clust_assigns = data.frame(x = c(1,2)))$plot),
    TRUE)

  # check that a tibble is returned with summary data
  expect_equal(
    is.data.frame(
      kmeans_report(data = data.frame(x = c(1,5),
                                      y = c(2,-5),
                                      z = c(3,0)),
                    clust_assigns = data.frame(x = c(1,2)))$summary),
    TRUE)
})
