#' Threat and demography scores from Analysis 1.
#'
#' Threat and demography scores derived from 5-year reviews and Fed. Reg.
#' documents
#'
#' @format A data frame with NNN observations and 4 variables
#' \describe{
#' \item{\code{Species}}{The species that was scored}
#' \item{\code{Threat_allev}}{The score for the threat change status}
#' \item{\code{Improve_demo}}{The score for the demographic change status}
#' \item{\code{Listing_chng}}{How the listic status is proposed to change}
#' \item{\code{five.yr_revw}}{Date of the 5-yr review}
#' \item{\code{listing_date}}{Date the species was listed under the ESA}
#' \item{\code{act_recov_pl}}{Date of the (active) recovery plan}
#' \item{\code{Comments}}{Comments made by WMW during data collection}
#' \item{\code{time_listed}}{How long the species has been ESA-listed (days)}
#' \item{\code{time_plans}}{How long the species has had a recovery plan (days)}
#' \item{\code{time_review}}{How long since the species had a status review (days)}
#' \item{\code{status_cat}}{Proposed status change category}
#' \item{\code{combined_components}}{Sum of threat and demography scores}
#' }
#' @source Defenders of Wildlife
"change"

#' Data from LDA classification of FWS status changes and threat & demography scores.
#'
#' The discriminant function analyses that gave rise to this data are in the
#' Analysis 1 vignette.
#'
#' @format A data frame with 36 observations and 6 variables
#' \describe{
#' \item{\code{Model}}{Which of four models gave these results}
#' \item{\code{classify}}{The LDA-based classification}
#' \item{\code{FWS_rec}}{FWS's status change recommendation}
#' \item{\code{Pct_cross}}{The percentage of species in this combo}
#' \item{\code{N_cross}}{The number of species in this combo}
#' \item{\code{col}}{The color that should be used in the plot}
#' }
#' @source data source, if any
"lda_class"

#' Threat and demography scores for 54 ESA-listed species in FL.
#'
#' We scored the threat and demographic changes for 54 ESA-listed, non-plant
#' species in Florida over which FWS has primary jurisdiction.
#'
#' @format A data frame with 50 observations and 4 variables
#' \describe{
#' \item{\code{Species}}{The species that was scored}
#' \item{\code{Demography}}{The score for the demographic change status}
#' \item{\code{Threat}}{The score for the threat change status}
#' \item{\code{Recommendation}}{FWS status change recommendation from biennial report to Congress, 2012.}
#' }
#' @source Defenders of Wildlife
"FL_all"

#' Threat and demography scores from multiple scorers.
#'
#' To evaluate the consistency of scoring threat and demographic status from
#' multiple people, five individuals used 5-yr reviews and Fed. Reg. documents
#' to derive scores for ten randomly selected FL species using a scoring key.
#'
#' @format A data frame with 54 observations and 4 variables
#' \describe{
#' \item{\code{Person}}{Individual who generated the scores}
#' \item{\code{Species}}{The species that was scored}
#' \item{\code{Threat}}{The score for the threat change status}
#' \item{\code{Demography}}{The score for the demographic change status}
#' }
#' @source Defenders of Wildlife
"multi"
