#' Calculate the p-values for an nnet::multinomial model.
#'
#' Uses pnorm of the zscore to return approximate p-values for model mod.
#'
#' @param mod The results for a multinom model
#' @return A matrix of p-values for predictors and response categories.
#' @seealso nnet::multinomial
#' @export
get_multinom_p <- function(mod) {
  zscore <- summary(mod)$coefficients / summary(mod)$standard.errors
  mod_p <- (1 - pnorm(abs(zscore), 0, 1)) * 2
  return(mod_p)
}

#' Calculate consistency (and deviations thereof) for an LDA model.
#'
#' Tabulates the observed response variable and the classifications from the
#' LDA model to calculate proportions assigned correctly between classes and
#' overall consistency of assignments.
#' @param dat The data on which the LDA was run
#' @param mod The results of an LDA model
#' @return A list with:
#' \itemize{
#'  \item{marg_tab}{The margin table}
#'  \item{diag_marg_tab}{The diagonal of the margin table}
#'  \item{consistency}{The sum of the diagonal, for overall consistency}}
#' @seealso MASS::lda
#' @export
get_lda_comps <- function(dat, mod) {
  ct_score_alt <- table(dat$status_cat, mod$class)
  marg_tab <- prop.table(ct_score_alt, 1)
  diag_marg_tab <- diag(marg_tab)
  consistency <- sum(diag(prop.table(ct_score_alt)))
  return(list(marg_tab = marg_tab,
              diag_marg_tab = diag_marg_tab,
              consistency = consistency))
}
