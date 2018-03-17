#' k-means clustering
#'
#'
#' @param data  - the data object (data frame or matrix) that k-means clustering will be applied to.
#' @param centers - the matrix containing the initial centers as computed by kmeans_init
#' @return - the cluster assignments and the data object stored in a list
#'
#'
kmeans_cluster <- function(data, centers, max_iter=100) {

  # check to make sure the data and centers are data frame or matrix
  if (!is.data.frame(data) & !is.matrix(data)) {
    stop("Data object is missing or in the wrong format.")
  } else if (!is.data.frame(centers) & !is.matrix(centers)) {
    stop("Centers object is missing or in the wrong format.")
  }

  # convert them to matrices because mix of df and mat is gross
  data <- as.matrix(data)
  centers <- as.matrix(centers)

  # intialize distance matrix of zeros
  dist_arr <- matrix(0, nrow=nrow(data), nrow(centers))

  # dummy assignment for first iteration
  last_assign <- -rep(1, nrow(data))
  iter_count <- 1

  for (iter in 1:max_iter) {

    # compute distance between each point and all centers
    for (c in 1:nrow(centers)) {
      dist_arr[,c] <- apply(t(t(data) - centers[c,]), 1, function(x) sqrt(sum(x^2)))
    }

    # update assignments based on distances
    cur_assign <- apply(dist_arr, 1, which.min)

    # update centers
    for (j in 1:nrow(centers)) {
      for (dim in 1:ncol(centers))
        centers[j,dim] <- mean(data[cur_assign == j,dim])
    }

    # check if assignments changed since last time
    if (isTRUE(all.equal(cur_assign, last_assign))) {
      return(cbind(data.frame(assignments=cur_assign),
                   as.data.frame(data)))
    }

    # move current assignments to last assignments
    last_assign <- cur_assign
  }
  # warn the user if we didn't converge in max_iter number of iterations
  warning("Did not converge in specified number of iterations")
  return(cbind(data.frame(assignments=cur_assign),
               as.data.frame(data)))

}
