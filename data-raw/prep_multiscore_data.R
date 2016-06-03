# Prep the multi-person FL spp. scoring data.

multi <- readxl::read_excel("data-raw/FL_scores_multi.xlsx")
multi <- multi[, 1:4]
head(multi)
dim(multi)
multi$Threat <- as.numeric(multi$Threat)
multi$Demography <- as.numeric(multi$Demography)

devtools::use_data(multi, overwrite = TRUE)
