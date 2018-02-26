\name{kmeans_init}
\alias{kmeans_init}
\title{Choose Initial K-Means Values}
\description{
Selects initial values (or seeds) for k-means clustering based on the input data object. K number of initial values are chosen by applying the specified algorithm.
}
\usage{
kmeans_init(data, K, algorithm = "k-means++")
}
\arguments{
  \item{data}{the data object (data frame or matrix) that k-means clustering will be applied to.}
  \item{K}{the number of initial values to be chosen. Should correspond to the number of clusters to be chosen.}
  \item{algorithm}{the initialisation algorithm specified as a string.}
}
\value{

}
\examples{

# create input data object with two distinct clusters
data = data.frame(x = runif(100, min = 0, max = 10) + rep(c(0, 10), 50), y = rnorm(100, 5, 1) + rep(c(0, 10), 50))

kmeans_init(data = data, K = 2)

}
