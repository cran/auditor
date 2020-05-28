## ----setup, echo = FALSE------------------------------------------------------
knitr::opts_chunk$set(warning = FALSE)
knitr::opts_chunk$set(message = FALSE)

## -----------------------------------------------------------------------------
library(DALEX)
data(dragons)
head(dragons)

## -----------------------------------------------------------------------------
# Linear regression
lm_model <- lm(life_length ~ ., data = dragons)

# Random forest
library(randomForest)
set.seed(59)
rf_model <- randomForest(life_length ~ ., data = dragons)

## ----results = 'hide'---------------------------------------------------------
lm_exp <- DALEX::explain(lm_model, label = "lm", data = dragons, y = dragons$life_length)
rf_exp <- DALEX::explain(rf_model, label = "rf", data = dragons, y = dragons$life_length)

## -----------------------------------------------------------------------------
library(auditor)
lm_cd <- model_cooksdistance(lm_exp)

## -----------------------------------------------------------------------------
plot(lm_cd)

