#` Choose Initial K-Means Values
#`
#`
#` @param data the data object (data frame or matrix) that k-means clustering will be applied to.
#` @param K the number of initial values to be chosen. Should correspond to the number of clusters to be chosen.
#` @param algorithm the initialisation algorithm specified as a string.
#` @return A matrix with coordinates for initialization values, where each row is an initialization value and the columns correspond with the columns of the input data object.
#` @examples
#` # create input data object with two distinct clusters
#` data = data.frame(x = runif(100, min = 0, max = 10) + rep(c(0, 10), 50), y = rnorm(100, 5, 1) + rep(c(0, 10), 50))
#`
#` kmeans_init(data = data, K = 2)
kmeans_init <- function(data, K, algorithm = "k-means++") {
  
}
