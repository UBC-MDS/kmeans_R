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
  
  # format as matrix in case of data frame
  data <- as.matrix(data)
  
  # initialize
  centroids <- list()
  
  
  # kmeans++ algorithm
  
  # use first observation as random first centroid
  centroids[[1]] <- data[1, ]
  
  
  # assign rest of centroids
  for (count in 2:K){
    cluster_dist <- c()
    
    for (point in 1:nrow(data)){
      cluster_dist[point] <- min(sapply(1:length(centroids), function(x) 
        sum((data[point, ] - centroids[[x]])^2)))
    }
    
    dist_cumsum <- sum(cluster_dist)
    
    cluster_dist_cum_probs <- c()
    
    for (cum_count in 1:length(cluster_dist)){
      prob <- cluster_dist[cum_count]/dist_cumsum
      if (cum_count == 1){
        cluster_dist_cum_probs[cum_count] <- prob
      }else{
        cluster_dist_cum_probs[cum_count] <- 
          cluster_dist_cum_probs[cum_count - 1] + prob
      }
    }
    
    
    # random sample from uniform distribution
    init_samp <- runif(1)
    
    # centre selected based on cdf
    for (cum_count in 1:nrow(data)){
      if (init_samp < cluster_dist_cum_probs[cum_count]){
        cent <- cum_count
        break
      }
    }
    
    # add centroid
    centroids[[length(centroids) + 1]] <- data[cent, ]
    
  }
  
  # format as matrix
  centroids <- matrix(unlist(centroids), ncol = ncol(data), byrow = TRUE)
  
  return(centroids)

}
