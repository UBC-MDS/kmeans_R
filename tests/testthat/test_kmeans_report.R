# Kmeans plot tests
#
# Testing includes:
#  - graceful failure when handed null data
#  - graceful failure when cluster assignments are missing
#  - checks that a plot file is actually produced and saved

library(kmeansR)
context("kmeans plotting")

test_that("kmeans_plot successfully plots the data and cluster assignments", {

  # test that the correct error is thrown in the absence of data
  expect_error(kmeans_report(data = NULL),
               "Data object is missing or in the wrong format. Make sure you input a matrix or data frame data object")


  # test that the correct error is thrown in the absense of cluster assignemnts
  expect_error(kmeans_report(data = data.frame(), clust_assigns = NULL),
               "Cluster assignements are in the wrong format. Make sure you input a list")

  # test that an image file is produced
  expect_true(file.exists(file.path(system.file("images", package="kmeansR"), "cluster_plot.png")))
})
