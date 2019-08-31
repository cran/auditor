#' @title Residual Density Plot
#'
#' @description Density of model residuals.
#'
#' @param object An object of class 'auditor_model_residual' created with \code{\link{model_residual}} function.
#' @param variable Split plot by variable's factor level or median.
#' If \code{variable="_y_"}, the plot will be splitted by actual response (\code{y} parameter
#' passed to the \code{\link[DALEX]{explain}} function).
#' If \code{variable = "_y_hat_"} the plot will be splitted by predicted response.
#' If \code{variable = NULL}, the plot will be splitted by observation index
#' If \code{variable = ""} plot is not splitted (default option).
#' @param ... Other 'auditor_model_residual' objects to be plotted together.
#'
#' @return ggplot object
#'
#' @examples
#' dragons <- DALEX::dragons[1:100, ]
#'
#' # fit a model
#' model_lm <- lm(life_length ~ ., data = dragons)
#'
#' # use DALEX package to wrap up a model into explainer
#' exp_lm <- DALEX::explain(model_lm, data = dragons, y = dragons$life_length)
#'
#' # validate a model with auditor
#' library(auditor)
#' mr_lm <- model_residual(exp_lm)
#'
#' # plot results
#' plot_residual_density(mr_lm)
#' plot(mr_lm, type = "residual_density")
#'
#' library(randomForest)
#' model_rf <- randomForest(life_length~., data = dragons)
#' exp_rf <- DALEX::explain(model_rf, data = dragons, y = dragons$life_length)
#' mr_rf <- model_residual(exp_rf)
#' plot_residual_density(mr_lm, mr_rf)
#' plot(mr_lm, mr_rf, type = "residual_density")
#'
#' @seealso \code{\link{plot_residual}}
#'
#' @import ggplot2
#'
#' @rdname plot_residual_density
#'
#' @export
plot_residual_density <- function(object, ..., variable = "") {
  # some safeguard
  `_residuals_` <- label <- div <- NULL

  # check if passed object is of class "auditor_model_residuals"
  check_object(object, type = "res")

  # data frame for ggplot object
  df <- make_dataframe(object, ..., variable = variable, type = "dens")

  # some helpfull objects
  model_count <- nlevels(df$`_label_`)
  df$`_ord_` <- paste(rev(as.numeric(df$`_label_`)), df$`_label_`)

  split <- TRUE

  if (!is.null(variable)) {
    if (variable == "") split <- FALSE
  }

  var_split <- "`_label_`"

  # arguments differ depending on splitting or not
  if (split == TRUE) {
    colours <- theme_drwhy_colors(nlevels(df$`_div_`))
    legend_pos <- "bottom"
    legend_just <- "center"
  } else {
    colours <- theme_drwhy_colors(model_count)
    legend_pos <- "top"
    legend_just <- c(1, 0)
  }

  if (model_count == 1) legend_pos <- "none"

  p <- ggplot(data = df, aes(x = `_residuals_`)) +
    geom_density(alpha = 0.3, aes_string(fill = var_split)) +
    geom_rug(aes_string(color = var_split), alpha = 0.5, show.legend = FALSE) +
    geom_vline(xintercept = 0, colour = "darkgrey") +
    annotate("segment", x = -Inf, xend = Inf,  y = -Inf, yend = -Inf, colour = "#371ea3") +
    scale_color_manual(values = colours) +
    scale_fill_manual(values = colours, breaks = unique(df$`_label_`)) +
    guides(fill = guide_legend(override.aes = list(alpha = 0.5))) +
    theme_drwhy() +
    theme(axis.line.x = element_line(color = "#371ea3"),
          legend.text = element_text(margin = margin(r = 5, l = 3)),
          legend.key = element_rect(colour = NA, fill = NA),
          legend.position = legend_pos,
          legend.justification = legend_just) +
    xlab("") + ylab("") + ggtitle("Residuals density")

  if (split == FALSE) {
    p
  } else {
    p + facet_wrap(. ~ `_div_`, scales = "free_x", ncol = 2) +
      theme(strip.text = element_text(colour = "#160e3b", size = rel(0.9), hjust = 0.5),
            panel.spacing.x = unit(1.2, "lines"),
            strip.text.x = element_text(margin = margin(0.5, 0, 0.2, 0, "cm")))
  }
}


#' @rdname plot_residual_density
#' @export
plotResidualDensity <- function(object, ..., variable = NULL) {
  message("Please note that 'plotResidualDensity()' is now deprecated, it is better to use 'plot_residual_density()' instead.")
  plot_residual_density(object, ..., variable = variable)
}