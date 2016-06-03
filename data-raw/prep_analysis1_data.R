# Prepare data from analysis 1.
library(readr)
fil <- "data-raw/RecoveryActs_near-final.tab"
dat <- read_tsv(fil)

dat$combined_components <- dat$Threat_allev + dat$Improve_demo

change <- dat[, c(1, 12:17, 21:25, 28)]
change <- dplyr::distinct(change)
head(change)
names(change)

devtools::use_data(change, overwrite = TRUE)
