
<!-- README.md is generated from README.Rmd. Please edit that file -->

# DS401

<!-- badges: start -->
<!-- badges: end -->

The goal of the DS401 R package is to assess quality of 3d topographics
scans in form of x3p images.

## Installation

You can install the development version of DS401 from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("heike/DS401")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(DS401)
## basic example code
library(x3ptools)
```

### This scan has a lot of problems

``` r
x3p_image(fau277_bb_l2, file = "man/figures/fau277_bb_l2.png")
```

<img src="man/figures/fau277_bb_l2.png" width="100%" />

The `DS401` package combines a set of functions assessing the quality of
scans.

### Feature extracted

`extract_na` calculates the percentage of values that are missing in the
surface matrix of the scan. For the scan shown above, this percentage is
quite high:

``` r
extract_na(fau277_bb_l2)
#> [1] 38.26887
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
