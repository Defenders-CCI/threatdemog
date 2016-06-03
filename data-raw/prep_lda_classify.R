# Prep the LDA classification data.

lda_class <- readr::read_tsv("data-raw/classification_data.tab")
head(lda_class)

devtools::use_data(lda_class, overwrite = TRUE)
