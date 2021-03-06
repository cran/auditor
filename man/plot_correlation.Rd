% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_correlation.R
\name{plot_correlation}
\alias{plot_correlation}
\alias{plotModelCorrelation}
\title{Correlation of Model's Residuals Plot}
\usage{
plot_correlation(object, ..., values = "fit")

plotModelCorrelation(object, ..., values = "fit")
}
\arguments{
\item{object}{An object of class \code{auditor_model_residual} created with \code{\link{model_residual}} function.}

\item{...}{Other \code{auditor_model_residual} objects to be plotted together.}

\item{values}{"fit" for model fitted values or "res" for residual values.}
}
\value{
Invisibly returns a \code{\link[gtable]{gtable}} object.
}
\description{
Matrix of plots. Left-down triangle consists of plots of fitted values (aternatively residuals),
on the diagonal there are density plots of fitted values (alternatively residuals), in the right-top triangle
there are correlations between fitte dvalues (alternatively residuals).
}
\examples{
dragons <- DALEX::dragons[1:100, ]

# fit a model
model_lm <- lm(life_length ~ ., data = dragons)

# use DALEX package to wrap up a model into explainer
lm_audit <- audit(model_lm, data = dragons, y = dragons$life_length)

# validate a model with auditor
mr_lm <- model_residual(lm_audit)

library(randomForest)
model_rf <- randomForest(life_length~., data = dragons)
rf_audit <- audit(model_rf, data = dragons, y = dragons$life_length)
mr_rf <- model_residual(rf_audit)

# plot results
plot_correlation(mr_lm, mr_rf)
plot(mr_lm, mr_rf, type = "correlation")


}
