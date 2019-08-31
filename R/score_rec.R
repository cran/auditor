#' @title Area Over the Curve for REC Curves
#'
#' @description The area over the Regression Error Characteristic curve is a measure of the expected error
#' for the regression model.
#'
#' @param object An object of class 'explainer' created with function \code{\link[DALEX]{explain}} from the DALEX package.
#'
#' @return an object of class 'score_audit'.
#'
#' @examples
#' dragons <- DALEX::dragons[1:100, ]
#'
#' # fit a model
#' lm_model <- lm(life_length ~ ., data = dragons)
#'
#' # create an explainer
#' lm_exp <- DALEX::explain(lm_model, data = dragons, y = dragons$life_length)
#'
#' # calculate score
#' score_rec(lm_exp)
#'
#'
#' @seealso \code{\link{plot_rec}}
#'
#' @references J. Bi, and K. P. Bennet, "Regression error characteristic curves," in Proc. 20th Int. Conf. Machine Learning, Washington DC, 2003, pp. 43-50
#'
#' @export


score_rec <- function(object) {
  if(!("explainer" %in% class(object))) stop("The function requires an object created with explain() function from the DALEX package.")

  object <- model_residual(object)

  rec_df <- make_rec_df(object)
  x <- rec_df$`_rec_x_`
  y <- rec_df$`_rec_y_`

  aoc <- max(x) * max(y)
  for (i in 2:length(x)) {
    aoc <- aoc - 0.5 * (x[i] - x[i - 1]) * (y[i] + y[i - 1])
  }

  rec_results <- list(
    name = "rec",
    score = aoc
    )

  class(rec_results) <- "score_audit"
  rec_results
}

# getRECDF is in plotREC.R file

#' @rdname score_rec
#' @export
scoreREC<- function(object) {
  message("Please note that 'scoreREC()' is now deprecated, it is better to use 'score_rec()' instead.")
  score_rec(object)
}