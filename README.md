
<img src="docs/images/logo_R_crop.png" align="right" border = "10" />

# kmeans_R

[![GitHub issues](https://img.shields.io/github/issues/UBC-MDS/kmeans_R.svg)](https://github.com/UBC-MDS/kmeans_R/issues)

## Overview

**kmeans_R** is an R package aimed towards a user-friendly way of exploring and implementing k-means clustering.

The package integrates and simplifies different functions, such as [kmeans](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/kmeans.html) and [KMeans_rcpp](https://cran.r-project.org/web/packages/ClusterR/ClusterR.pdf), into one easy-to-use package.

The package includes the following functions:

* `kmeans++(data, K)` Implementation of the [kmeans++](https://en.wikipedia.org/wiki/K-means%2B%2B) initialization algorithm. Returns `K` number of initial centers based on the input `data`.

* `kmeans(data, centers_init)` Classifies each observation in `data` by performing k-means clustering. The number of clusters is derived from the number of initial centers specified in `centers_init`. Returns an object containing the original data and assigned cluster labels.

* `kmeans_plot(obj)` Visualizes clustered data using an object that is formatted in the same way as the object returned by the `kmeans` function.

## Contributors

[Bradley Pick](https://github.com/bradleypick)

[Charley Carriero](https://github.com/charcarr)

[Johannes Harmse](https://github.com/johannesharmse)
