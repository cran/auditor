## ----setup, echo = FALSE------------------------------------------------------
knitr::opts_chunk$set(warning = FALSE)
knitr::opts_chunk$set(message = FALSE)

## -----------------------------------------------------------------------------
library(DALEX)
head(titanic_imputed)

## -----------------------------------------------------------------------------
model_glm <- glm(survived ~ ., data = titanic_imputed, family = "binomial")

library(randomForest)
model_rf <- randomForest(survived ~ ., data = titanic_imputed)

## ----results = 'hide'---------------------------------------------------------
library(auditor)
exp_glm <- audit(model_glm, data = titanic_imputed, y = titanic_imputed$survived)
exp_rf <- audit(model_rf, data = titanic_imputed, y = titanic_imputed$survived)

## -----------------------------------------------------------------------------
eva_glm <- model_evaluation(exp_glm)
eva_rf <- model_evaluation(exp_rf)

## -----------------------------------------------------------------------------
plot(eva_glm, eva_rf, type = "roc")
# or
# plot_roc(eva_glm, eva_rf)

## -----------------------------------------------------------------------------
plot(eva_glm, eva_rf, type = "lift")
# or
# plot_lift(eva_glm, eva_rf)

