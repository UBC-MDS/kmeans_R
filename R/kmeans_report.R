#' Plot data according to cluster assigments
#'
#'
#' @param data -- the data object (data frame or matrix) that k-means clustering has been applied to
#' @param clust_assigns -- cluster assignments that correspond to each data point
#' @return plot -- a scatter plot of the data coloured by cluster assignment (if 2D data)
#'              -- a data frame reporting points and their cluster assignemnts
#'
#' example:
#' kmeans_report(data = data, clust_assigns = clusters)

suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(ggplot2))

kmeans_report <- function(data, clust_assigns) {

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
    mutate(cluster = as.factor(as.vector(clust_assigns[,1]))) %>%
    select(cluster, everything())

  summary_df <- assignment_df %>%
    group_by(cluster) %>%
    summarise(count = n())

  if (ncol(data) == 2) {
    p <- ggplot(assignment_df, aes(x = assignment_df[,2],
                                   y = assignment_df[,3],
                                   colour = cluster)) +
      geom_point() +
      labs(x = "X", y = "Y", title = "cluster assignments" ) +
      scale_colour_discrete() +
      theme_minimal()

    return(list(assignments=assignment_df, plot=p, summary=summary_df))

  } else{
    return(list(assignments=assignment_df, summary=summary_df))
  }

}
