
<img src="docs/images/logo_R_crop.png" align="right" border = "10" width="300" height="300"/>

# kmeans_R

[![Build Status](https://travis-ci.org/UBC-MDS/kmeans_R.svg?branch=master)](https://travis-ci.org/UBC-MDS/kmeans_R)
[![GitHub issues](https://img.shields.io/github/issues/UBC-MDS/kmeans_R.svg)](https://github.com/UBC-MDS/kmeans_R/issues)

## Installation

Install this package directly from GitHub:

``` r
devtools::install_github("UBC-MDS/kmeans_R")
```

## Usage

Simple example demonstrating the functionality of this package:

``` r
# load package                                                   
library(kmeansR)                                                 

# generate synthetic data with three clusters                    
synth_data <- data.frame(                                        
x = c(rnorm(20,1,1), rnorm(30,6,3), rnorm(15,10,2)),             
y = c(rnorm(20,5,2), rnorm(30,2,2), rnorm(15,8,3))               
)                                                                

# initialize the cluster centers                                 
centers <- kmeans_init(data = synth_data, K = 3)                 
# cluster the data points                                        
clustered <- kmeans_cluster(data = synth_data, centers = centers)
# generate summary results                                       
report <- kmeans_report(clustered_data = clustered)              

# plot the clustered data                                        
report$plot                                                      
```

![](https://i.imgur.com/GR92mzl.png)

``` r
report$summary                                                   
#> # A tibble: 3 x 2
#>   cluster count
#>   <fct>   <int>
#> 1 1          31
#> 2 2          12
#> 3 3          22
```

## Overview

**kmeans_R** is an R package aimed towards a user-friendly way of exploring and
implementing [k-means clustering](https://en.wikipedia.org/wiki/K-means_clustering).

The package offers simple and easy to use functions that perform k-means clustering.
In particular, the different stages of clustering are broken up into separate
functions (initialization, clustering, and plotting). This allows the user
to investigate exactly what is going on at each step, which promotes an
understanding of this disparate aspects of the clustering procedure.
Furthermore, the plotting (perhaps the most rewarding part of the process)
can be done easily - assuming we are in two dimensions - and results in
visually appealing images (thanks to [`ggplot2`](http://ggplot2.org/))
An example of how this organizational pattern could prove useful is
as an aid to understanding kmeans clustering. Other packages in the R ecosystem
that are related/overlap with this package are:
[kmeans](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/kmeans.html) and [KMeans_rcpp](https://cran.r-project.org/web/packages/ClusterR/ClusterR.pdf).

The package includes the following functions:

* `kmeans_init(data, K, method = "kmeanspp", seed = NULL)` Selects initial values (or seeds) for k-means clustering based on the input `data` object. `K` number of initial values are chosen by applying the specified `method`. Returns a matrix with coordinates for initialization values, where each row is an initialization value and the columns correspond with the columns of the input data object.

* `kmeans_cluster(data, centers, max_iter=100)` Classifies each observation in `data` by performing k-means clustering. The number of clusters is derived from the number of initial centers specified in `centers`. `max_iter` defaults to 100 and simply places an upper bound on the number of iterations that take place. Returns a data frame containing the original data and new column of assigned cluster labels.

* `kmeans_report(clustered_data)` Visualizes clustered data using the `clustered_data`
as computed by the cluster function. Returns a list containing
a data frame with original data and assignments, a plot object if data is two dimensional,
and a summary table containing counts of the number of points in each cluster.

## Contributors

[Bradley Pick](https://github.com/bradleypick)

[Charley Carriero](https://github.com/charcarr)

[Johannes Harmse](https://github.com/johannesharmse)
