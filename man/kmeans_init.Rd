\name{kmeans_init}
\alias{kmeans_init}
\title{Choose Initial K-Means Values}
\description{
Selects initial values for k-means clustering based on the input data object. K number of initial values are chosen by applying the specified method.
}
\usage{
kmeans_init(data, K, method = "kmeanspp", seed = NULL)
}
\arguments{
  \item{data}{the data object (data frame or matrix) that k-means clustering will be applied to.}
  \item{K}{the number of initial values to be chosen. Should correspond to the number of clusters to be chosen.}
  \item{method}{"kmeanspp" or "rp". The initialisation method specified as a string. "kmeanspp" refers to kmeans++ method and "rp" refers to random points method. More information on kmeans initialization methods can be found \href{https://arxiv.org/pdf/1209.1960.pdf}{here}.}
}
  \item{seed}{the seed to be set if "rp" is specified as method. If NULL, no seed will be set.}
\value{
A matrix with coordinates for initialization values, where each row is an initialization value and the columns correspond with the columns of the input data object.
}
\examples{

# create input data object with two distinct clusters
data = data.frame(x = runif(100, min = 0, max = 10) + rep(c(0, 10), 50), y = rnorm(100, 5, 1) + rep(c(0, 10), 50))

kmeans_init(data = data, K = 2)

}
