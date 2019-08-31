## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(message = FALSE)
knitr::opts_chunk$set(warning = FALSE)

## ------------------------------------------------------------------------
library(DALEX)
data("dragons")
head(dragons)

## ------------------------------------------------------------------------
lm_model <- lm(life_length ~ ., data = dragons)

## ------------------------------------------------------------------------
library("randomForest")
set.seed(59)
rf_model <- randomForest(life_length ~ ., data = dragons)

## ------------------------------------------------------------------------
lm_exp <- DALEX::explain(lm_model, label = "lm", data = dragons, y = dragons$life_length)
rf_exp <- DALEX::explain(rf_model, label = "rf", data = dragons, y = dragons$life_length)

## ------------------------------------------------------------------------
library(auditor)
lm_mr <- model_residual(lm_exp)
rf_mr <- model_residual(rf_exp)


## ------------------------------------------------------------------------
plot(lm_mr, type = "acf", variable = "year_of_discovery")

# alternative:
# plot_acf(lm_mr, variable = "year_of_discovery")

## ------------------------------------------------------------------------
plot(rf_mr, type = "autocorrelation")

# alternative:
# plot_autocorrelation(rf_mr)

## ------------------------------------------------------------------------
rf_score_dw <- score_dw(rf_exp)
rf_score_runs <- score_runs(rf_exp)

rf_score_dw$score
rf_score_runs$score

## ------------------------------------------------------------------------
plot(rf_mr, lm_mr, type = "correlation")

# alternative:
# plotM_correlation(rf_mr, lm_mr)

## ------------------------------------------------------------------------
plot(rf_mr, lm_mr, type = "pca")

# alternative:
# plot_pca(rf_audit, lm_audit)

## ------------------------------------------------------------------------
plot(rf_mr, lm_mr, variable = "life_length", type = "prediction")

# alternative:
# plot_prediction(rf_audit, lm_audit, variable = "life_length")

## ------------------------------------------------------------------------
plot(rf_mr, lm_mr, type = "prediction")

# alternative:
# plot_prediction(rf_mr, lm_mr)

## ------------------------------------------------------------------------
plot(rf_mr, lm_mr, type = "rec")

# alternative:
# plot_rec(rf_mr, lm_mr)

## ------------------------------------------------------------------------
plot(rf_mr, type = "residual")

# alternative:
# plot_residual(rf_mr)

## ------------------------------------------------------------------------
plot(rf_mr, lm_mr, type = "residual", variable = "_y_hat_")

# alternative:
# plot_residual(rf_mr, lm_mr, variable = "_y_hat_")

## ------------------------------------------------------------------------
plot(lm_mr, rf_mr, type = "residual_boxplot")

# alternative
# plot_residual_boxplot(lm_mr, rf_mr)

## ------------------------------------------------------------------------
plot(rf_mr, lm_mr, type = "residual_density")

# alternative
# plot_residual_density(rf_mr, lm_mr)

## ------------------------------------------------------------------------
plot_residual_density(rf_mr, lm_mr, variable = "life_length")

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
# plot_tsecdf(rf_audit, lm_audit)

