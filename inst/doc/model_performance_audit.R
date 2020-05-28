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
lm_mp <- model_performance(lm_exp)
rf_mp <- model_performance(rf_exp)

lm_mp

## -----------------------------------------------------------------------------
plot(lm_mp, rf_mp)
# alternative:
# plot_radar(lm_mp, rf_mp, verbose = FALSE)


## -----------------------------------------------------------------------------
new_score <- function(object) sum(sqrt(abs(object$residuals)))

lm_mp <- model_performance(lm_exp,  
                          score = c("mae", "mse", "rec", "rroc"), 
                          new_score = new_score)

rf_mp <- model_performance(rf_exp,  
                          score = c("mae", "mse", "rec", "rroc"), 
                          new_score = new_score)

plot(lm_mp, rf_mp)

