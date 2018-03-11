\name{kmeans_cluster}
\alias{kmeans_cluster}
\title{Use kmeans clustering for a collection of points}
\description{
Given the data and the initial cluster centers, apply kmeans to cluster the data.
}
\usage{
kmeans_cluster(data, centers, max_iter=100)
}
\arguments{
  \item{data}{the data object (data frame or matrix) that k-means clustering will be applied to.}
  \item{centers}{the initial cluster centers as determined by kmeans_init.}
  \item{max_iter}{The maximum number of iterations to perform.}
}
\value{
A list containing cluster assignments and the original data frame
}
\examples{

# create input data object with two distinct clusters
data = data.frame(x = runif(100, min = 0, max = 10) + rep(c(0, 10), 50), y = rnorm(100, 5, 1) + rep(c(0, 10), 50))

centers <- kmeans_init(data = data, K = 2)
kmeans_cluster(data=data, centers=centers)

}
