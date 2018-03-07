#` Choose Initial K-Means Values
#`
#`
#` @param data  - the data object (data frame or matrix) that k-means clustering will be applied to.
#` @param centers - the matrix containing the initial centers as computed by kmeans++
#` @return - the cluster assignments and the data object stored in a list
#`
#`
kmeans_cluster <- function(data, centers, max_iter=100) {

  # convert them to matrices because mix of df and mat is gross
  data <- as.matrix(data)
  centers <- as.matrix(centers)

  # intialize distance matrix of zeros
  dist_arr <- matrix(0, nrow=nrow(data), nrow(centers))

  # dummy assignment for first iteration
  last_assign <- -rep(1, nrow(data))
  iter_count <- 1

  while (TRUE) {

    # compute distance between each point and all centers
    for (c in 1:nrow(centers)) {
      dist_arr[,c] <- apply(t(t(data) - centers[c,]), 1, function(x) sqrt(sum(x^2)))
    }

    # update assignments based on distances
    cur_assign <- apply(dist_arr, 1, which.min)

    # check if assignments changed since last time
    if (isTRUE(all.equal(cur_assign, last_assign))) {
      return(list(assignments=data.frame(assignments=cur_assign),
                  data=as.data.frame(data)))
    }

    # call new assignments old
    last_assign <- cur_assign

    # update centers
    for (j in 1:nrow(centers)) {
      for (dim in 1:ncol(centers))
      centers[j,dim] <- mean(data[cur_assign == j,dim])
    }

    # check if we are past the number of iterations
    if (iter_count > max_iter) {
      print("Did not converge")
      break
    }
    iter_count <- iter_count + 1


  }

}
