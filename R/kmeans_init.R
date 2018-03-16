#` Choose Initial K-Means Values
#`
#`
#` @param data the data object (data frame or matrix) that k-means clustering will be applied to.
#` @param K the number of initial values to be chosen. Should correspond to the number of clusters to be chosen.
#` @param method "kmeanspp" or "rp". The initialisation method specified as a string. "kmeanspp" refers to kmeans++ method and "rp" refers to random points method. More information on kmeans initialization methods can be found \href{https://arxiv.org/pdf/1209.1960.pdf}{here}.
#` @return A matrix with coordinates for initialization values, where each row is an initialization value and the columns correspond with the columns of the input data object.
#` @examples
#` # create input data object with two distinct clusters
#` data = data.frame(x = runif(100, min = 0, max = 10) + rep(c(0, 10), 50), y = rnorm(100, 5, 1) + rep(c(0, 10), 50))
#`
#` kmeans_init(data = data, K = 2)
kmeans_init <- function(data = NULL, K = NULL, method = "kmeanspp", seed = NULL) {

  if (is.null(data) ||
    (!is.data.frame(data) &&
      !is.matrix(data))){
    stop("Data object is missing or in the wrong format. Make sure you input a matrix or data frame data object")
  }else if(is.null(K) || !is.numeric(K) || (K %% 1) != 0){
    stop("K value is missing or not a numeric integer. Please specify the number of initial values/seeds as an integer.")
  }else if(K > nrow(data)){
    stop("Cannot generate more initializing values than available data points. Please select a K value smaller than the number of observations.")
  }

  if (K == 0){
    return(matrix(numeric(0), ncol = ncol(data), byrow = TRUE))
  }

  # format as matrix in case of data frame
  if (!is.matrix(data)){
    data <- as.matrix(data)
  }

  # initialize centroids
  centroids <- list()


  # kmeans++ method

  if (method == 'kmeanspp'){
    # use first observation as random first centroid starting point
    centroids[[1]] <- data[1, ]


    # assign rest of centroids

    # filter through number of centroid assignments (minus 1 that has already been created)
    for (count in 2:K){
      cluster_dist <- c()


      # cycly through all data points/possible centroids
      for (point in 1:nrow(data)){
        # determine closest existing centroid to point with squared sum
        cluster_dist[point] <- min(sapply(1:length(centroids), function(x)
          sum((data[point, ] - centroids[[x]])^2)))
      }

      # calculate normalizing factor
      dist_cumsum <- sum(cluster_dist)

      # initialize cdf
      cluster_dist_cum_probs <- c()

      # iterate through data point to centroid minimum distances
      for (cum_count in 1:length(cluster_dist)){
        # create pdf of distances
        prob <- cluster_dist[cum_count]/dist_cumsum
        # initial cdf assigning
        if (cum_count == 1){
          cluster_dist_cum_probs[cum_count] <- prob
        # create rest of cdf
        }else{
          cluster_dist_cum_probs[cum_count] <-
            cluster_dist_cum_probs[cum_count - 1] + prob
        }
      }


      # random sample from uniform distribution
      # we need to stipulate a random point somewhere in the cdf

      init_samp <- runif(1)

      # centre selected based on cdf
      # the sample value will have a higher probability of landing on a generally far away distance (clustered points in different cluster to centroids)
      # since these have the biggest weight/area in the cdf
      for (cum_count in 1:nrow(data)){
        # assign centroid based on where it cdf
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

  }else if(method == "rp"){
    # random points method

    if (!is.null(seed)){
      if (seed%%1 == 0){
        set.seed(seed)
      }else{
        stop("Invalid seed has been provided. Please specify seed as integer or omit.")
      }
    }

    # select random rows as initialization values
    cent <- sample(1:nrow(data), size = K, replace = FALSE)

    # assign centroids by subsetting data
    centroids <- data[cent, ]

    return(centroids)
  }

  else{
    stop("Please choose a valid method or revert to default.")
  }

}
