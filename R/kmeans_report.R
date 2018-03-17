#' Plot data according to cluster assigments
#'
#'
#' @param data -- the data object (data frame or matrix) that k-means clustering has been applied to
#' @param clust_assigns -- cluster assignments that correspond to each data point
#' @return plot -- a scatter plot of the data coloured by cluster assignment (if 2D data)
#'              -- a data frame reporting points and their cluster assignemnts
#'
#' @examples
#' kmeans_report(data = data, clust_assigns = clusters)
#'
#' @import dplyr
#' @import ggplot2
#' @import magrittr
#'
#' @export
kmeans_report <- function(data, clust_assigns) {
  # require(dplyr)
  # require(ggplot2)
  # require(magrittr)

  # library(dplyr)
  # library(ggplot2)

  #devtools::use_package("dplyr")
  #devtools::use_package("ggplot2")

  # check to make sure the data and centers are not NULL
  if (is.null(data)) {
    stop("Data object is missing or in the wrong format.")
  } else if (is.null(clust_assigns)) {
    stop("Cluster assignements are in the wrong format.")
  } else if(nrow(data) != nrow(clust_assigns)) {
    stop("Data and cluster assignmenments must be the same length!")
  }

  assignment_df <- data %>%
    dplyr::mutate(cluster = as.factor(as.vector(clust_assigns[,1]))) %>%
    dplyr::select(cluster, dplyr::everything())

  summary_df <- assignment_df %>%
    dplyr::group_by(cluster) %>%
    dplyr::summarise(count = n())

  if (ncol(data) == 2) {
    p <- ggplot2::ggplot(assignment_df,
                         ggplot2::aes(x = assignment_df[,2],
                                      y = assignment_df[,3],
                                      colour = cluster)) +
      ggplot2::geom_point() +
      ggplot2::labs(x = "X", y = "Y", title = "cluster assignments" ) +
      ggplot2::scale_colour_discrete() +
      ggplot2::theme_minimal()

    return(list(assignments=assignment_df, plot=p, summary=summary_df))

  } else{
    return(list(assignments=assignment_df, summary=summary_df))
  }

}
