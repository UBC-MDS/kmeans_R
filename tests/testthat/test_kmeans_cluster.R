# Kmeans clustering tests
#
# Testing includes:
#  - graceful failure when handed null data
#  - correctly clusters toy example
#  - checks that returns object of type list
#  - checks that the list contains the original data
#  - checks that the list contains the cluster assignments

library(kmeansR)
context("kmeans clustering")

test_that("kmeans_cluster is a list containing data and cluster assignments", {

 # test that the correct error is thrown in the absence of data
 expect_error(kmeans_cluster(data = NULL, centers=NULL),
               "Data object is missing or in the wrong format. Make sure you input a matrix or data frame data object")


 # test that we are actually getting a list
 expect_equal(is.list(kmeans_cluster(data = data.frame(x = c(1,5,1), y = c(2,-5,2), z = c(3,0,3)),
                          centers = data.frame(x=c(1,5),y=c(2,-5),z=c(3,0)))), TRUE)

 # test that the data element of returned list has correct shape
 expect_equal(nrow(kmeans_cluster(data = data.frame(x = c(1,5,1), y = c(2,-5,2), z = c(3,0,3)),
                          centers = data.frame(x=c(1,5),y=c(2,-5),z=c(3,0)))$data), 3)
 expect_equal(ncol(kmeans_cluster(data = data.frame(x = c(1,5,1), y = c(2,-5,2), z = c(3,0,3)),
                          centers = data.frame(x=c(1,5),y=c(2,-5),z=c(3,0)))$data), 3)

 # simple example where the resulting assignments can be computed by hand
 expect_equal(kmeans_cluster(data = data.frame(x = c(1,5,1), y = c(2,-5,2), z = c(3,0,3)),
                          centers = data.frame(x=c(1,5),y=c(2,-5),z=c(3,0)))$assignments,
                          data.frame(assignments=c(1,2,1)))


})
