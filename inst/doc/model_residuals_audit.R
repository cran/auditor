## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(message = FALSE)
knitr::opts_chunk$set(warning = FALSE)

## ------------------------------------------------------------------------
library(DALEX)
data(dragons)
head(dragons)

## ------------------------------------------------------------------------
# Linear regression
lm_model <- lm(life_length ~ ., data = dragons)

# Random forest
library(randomForest)
set.seed(59)
rf_model <- randomForest(life_length ~ ., data = dragons)

## ----results = 'hide'----------------------------------------------------
lm_exp <- DALEX::explain(lm_model, label = "lm", data = dragons, y = dragons$life_length)
rf_exp <- DALEX::explain(rf_model, label = "rf", data = dragons, y = dragons$life_length)

## ------------------------------------------------------------------------
library(auditor)
lm_mr <- model_residual(lm_exp)
rf_mr <- model_residual(rf_exp)

## ------------------------------------------------------------------------
plot(rf_mr, lm_mr, type = "prediction", abline = TRUE)
# alternatives:
# plot_prediction(rf_mr, lm_mr, abline = TRUE)
# plot_prediction(rf_mr, lm_mr, variable = "life_length")

## ----dodge-st, fig.show = "hold", out.width = "50%"----------------------
plot(rf_mr, lm_mr, variable = "scars", type = "prediction")
plot(rf_mr, lm_mr, variable = "height", type = "prediction")

## ------------------------------------------------------------------------
plot(lm_mr, rf_mr, type = "residual")

# alternative:
# plot_residual(lm_mr, rf_mr)

## ----fig.show = "hold", out.width = "50%"--------------------------------
plot(rf_mr, lm_mr, type = "residual", variable = "_y_hat_")
plot(rf_mr, lm_mr, type = "residual", variable = "scars")

# alternative:
# plot_residual(rf_mr, lm_mr, variable = "_y_hat_")
# plot_residual(rf_mr, lm_mr, variable = "scars")

## ----echo = FALSE--------------------------------------------------------
plot_residual(rf_mr, variable = "_y_hat_", nlabel = 10)

## ------------------------------------------------------------------------
# plot_residual(rf_mr, variable = "_y_hat_", nlabel = 10)

## ------------------------------------------------------------------------
plot(rf_mr, lm_mr, type = "residual_density")

# alternative
# plot_residual_density(rf_mr, lm_mr)

## ------------------------------------------------------------------------
plot_residual_density(rf_mr, lm_mr, variable = "colour")

## ------------------------------------------------------------------------
plot(lm_mr, rf_mr, type = "residual_boxplot")

# alternative
# plot_residual_boxplot(lm_mr, rf_mr)

## ------------------------------------------------------------------------
plot(lm_mr, type = "acf", variable = "year_of_discovery")

# alternative:
# plot_acf(lm_mr, variable = "year_of_discovery")

## ------------------------------------------------------------------------
plot(rf_mr, type = "autocorrelation")

# alternative:
# plot_autocorrelation(rf_mr)

## ------------------------------------------------------------------------
score_dw(rf_exp)$score
score_runs(rf_exp)$score

## ------------------------------------------------------------------------
plot(rf_mr, lm_mr, type = "correlation")

# alternative:
# plot_correlation(rf_mr, lm_mr)

## ------------------------------------------------------------------------
plot(rf_mr, lm_mr, type = "pca")

# alternative:
# plot_pca(rf_mr, lm_mr)

## ------------------------------------------------------------------------
plot(rf_mr, lm_mr, type = "rec")

# alternative:
# plot_rec(rf_mr, lm_mr)

## ------------------------------------------------------------------------
plot(rf_mr, lm_mr, type = "rroc")

# alternative:
# plot_rroc(rf_mr, lm_mr)

## ------------------------------------------------------------------------
plot(rf_mr, lm_mr, type = "scalelocation")

# alternative:
# plot_scalelocation(rf_mr, lm_mr)

## ------------------------------------------------------------------------
plot(rf_mr, lm_mr, type = "tsecdf")

# alternative
# plot_tsecdf(rf_mr, lm_mr)

