% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assess_rotation.r
\name{assess_rotation}
\alias{assess_rotation}
\title{Assess rotational imbalance of a scan}
\usage{
assess_rotation(x3p, width = 0.2)
}
\arguments{
\item{x3p}{scan in x3p format}

\item{width}{how wide are the bands that we want to compare on the left and the right?}
}
\value{
absolute value of the log of the ratio of the number of missing values on the left compared to the right side at the bottom and the middle of the scan.
}
\description{
A good quality of 3d scans is crucial for an assessment of similarity of
striation marks between different bullets.
Here, we assess rotational imbalance - we measure this as the ratio between
the difference in the number of missing values on the left and the right of a scan at two different heights.
A ratio of 1 would indicate a balance in the proportion of missing values between the left hand side and the right hand side of a scan.
Large deviations of 1 indicate an imbalance to the left or right. A log transform of the ratio akes the result symmetric around 0. Large deviations from 0 indicate a stronger deviation.
}
\examples{
data(fau277_bb_l2)
assess_rotation(fau277_bb_l2) # this scan has a particularly high percentage of missing values
assess_rotation(fau001_ba_l1) # good scan
}
