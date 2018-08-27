context("errors")
library(car)

test_that("data consistency", {
  expect_error( audit(model.lm, data = Prestige, y = c(1,2)))
})
test_that("objects", {
  expect_error(plotResidualBoxplot(model.lm))
})
