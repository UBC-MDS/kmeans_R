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
kmeans_init <- function(data = NULL, K = NULL, algorithm = "k-means++") {
  if (is.null(data) ||
    (!is.data.frame(data) &&
      !is.matrix(data))){
    stop("Data object is missing or in the wrong format. Make sure you input a matrix or data frame data object")
  }else if(is.null(K) || !is.numeric(K) || (K %% 1) != 0){
    stop("K value is missing or not a numeric integer. Please specify the number of initial values/seeds as an integer.")
  }

  return(0)

}
