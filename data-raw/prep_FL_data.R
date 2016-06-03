# Prep the score data for all Florida species.

FL_all <- readxl::read_excel("data-raw/FL_scores_all_spp.xlsx")
head(FL_all)
dim(FL_all)
FL_all$Threat <- as.numeric(FL_all$Threat)
FL_all$Demography <- as.numeric(FL_all$Demography)

devtools::use_data(FL_all, overwrite = TRUE)
