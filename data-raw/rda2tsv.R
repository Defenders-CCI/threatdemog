# Convert the .rda files to tsv for figshare.

library(readr)

load("data/change.rda")
load("data/FL_all.rda")
load("data/lda_class.rda")
load("data/multi.rda")

write_tsv(change, path = "data-raw/FWS_change_spp.tsv")
write_tsv(FL_all, path = "data-raw/all_FL_spp.tsv")
write_tsv(lda_class, path = "data-raw/LDA_data.tsv")
write_tsv(multi, path = "data-raw/FL_multiperson.tsv")
