#' Plot data according to cluster assigments
#'
#'
#' @param clustered_data -- the data object (data frame or matrix) that k-means clustering has been applied to
#' @return plot -- a scatter plot of the data coloured by cluster assignment (if 2D data)
#'              -- a data frame reporting points and their cluster assignemnts
#'
#' @examples
#' x <- runif(100, min = 0, max = 10) + rep(c(0, 10), 50)
#' y <- rnorm(100, 5, 1) + rep(c(0, 10), 50)
#' data = data.frame(x = x, y = y)
#'
#' centers <- kmeans_init(data = data, K = 2)
#' clustered_data <- kmeans_cluster(data=data, centers=centers)
#' kmeans_report(clustered_data)
#'
#' @import dplyr
#' @import ggplot2
#' @import magrittr
#'
#' @export
kmeans_report <- function(clustered_data) {

  # check to make sure the data and centers are not NULL
  if (!is.data.frame(clustered_data)) {
    stop("Data object is missing or in the wrong format.")
  }

  summary_df <- clustered_data %>%
    dplyr::group_by(cluster) %>%
    dplyr::summarise(count = n())

  if (ncol(clustered_data) == 3) {
    p <- ggplot2::ggplot(clustered_data,
                         ggplot2::aes(x = clustered_data[,2],
                                      y = clustered_data[,3],
                                      colour = cluster)) +
      ggplot2::geom_point() +
      ggplot2::labs(x = "X", y = "Y", title = "cluster assignments" ) +
      ggplot2::scale_colour_discrete() +
      ggplot2::theme_minimal()

    return(list(assignments=clustered_data, plot=p, summary=summary_df))

  } else{
    return(list(assignments=clustered_data, summary=summary_df))
  }

}
