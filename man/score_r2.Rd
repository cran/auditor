% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/score_r2.R
\name{score_r2}
\alias{score_r2}
\title{R-squared}
\usage{
score_r2(object, data = NULL, y = NULL, ...)
}
\arguments{
\item{object}{An object of class \code{explainer} created with function
\code{\link[DALEX]{explain}} from the DALEX package.}

\item{data}{New data that will be used to calcuate the score.
Pass \code{NULL} if you want to use \code{data} from \code{object}.}

\item{y}{New y parameter will be used to calculate score.}

\item{...}{Other arguments dependent on the type of score.}
}
\value{
An object of class \code{auditor_score}.
}
\description{
The R2 is the coefficient of determination,
An R2 coefficient equals 0 means that model explaines none of the variability of the response.
An R2 coefficient equals 1 means that model explains all the variability of the response.
}
\examples{
dragons <- DALEX::dragons[1:100, ]

# fit a model
model_lm <- lm(life_length ~ ., data = dragons)

# use DALEX package to wrap up a model into explainer
lm_audit <- audit(model_lm, data = dragons, y = dragons$life_length)

# calculate score with auditor
score_r2(lm_audit)

}
\seealso{
\code{\link{score}}
}
