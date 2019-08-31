## ----setup, echo = FALSE-------------------------------------------------
knitr::opts_chunk$set(warning = FALSE)
knitr::opts_chunk$set(message = FALSE)

## ------------------------------------------------------------------------
titanic <- na.omit(DALEX::titanic)
titanic$survived = as.numeric(titanic$survived)-1
head(titanic)

## ------------------------------------------------------------------------
model_glm <- glm(survived~., data = titanic, family = binomial)

library(e1071)
model_svm <- svm(survived~., data = titanic)

## ------------------------------------------------------------------------
exp_glm <- DALEX::explain(model_glm, data = titanic, y = titanic$survived)
exp_svm <- DALEX::explain(model_svm, data = titanic, y = titanic$survived, label = "svm")

## ------------------------------------------------------------------------
library(auditor)
eva_glm <- model_evaluation(exp_glm)
eva_svm <- model_evaluation(exp_svm)

## ------------------------------------------------------------------------
plot(eva_glm, eva_svm, type = "roc")
# or
# plot_roc(eva_glm, eva_svm)

## ------------------------------------------------------------------------
plot(eva_glm, eva_svm, type = "lift")
# or
# plot_lift(eva_glm, eva_svm)

