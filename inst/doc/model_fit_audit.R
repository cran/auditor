## ----setup, echo = FALSE-------------------------------------------------
knitr::opts_chunk$set(warning = FALSE)
knitr::opts_chunk$set(message = FALSE)

## ------------------------------------------------------------------------
library(auditor)
set.seed(123)

## ---- results='hide', fig.keep='all'-------------------------------------
data("corn", package = "hnp")
head(corn)

## ----binomial2, results='hide', fig.keep='all'---------------------------
model_bin <- glm(cbind(y, m - y) ~ extract, family = binomial, data = corn)

bin_exp <- DALEX::explain(model_bin, data = corn, y = corn$y)

## ------------------------------------------------------------------------
bin_hnp <- model_halfnormal(bin_exp)

## ------------------------------------------------------------------------
plot(bin_hnp, sim=500)
# or
# plot_halfnormal(bin_hnp, sim = 500)

## ---- results='hide', fig.keep='all'-------------------------------------
plot(bin_hnp, quantiles = TRUE)

## ------------------------------------------------------------------------
library(randomForest)
iris_rf <- randomForest(Species ~ ., data=iris)
iris_rf_exp <- DALEX::explain(iris_rf, data = iris, y = as.numeric(iris$Species)-1)
iris_rf_hnp <- model_halfnormal(iris_rf_exp)
plot_halfnormal(iris_rf_hnp)

