## ----setup, include=TRUE-------------------------------------------------
library(ggplot2)
library(ggthemes)
library(threatdemog)
load("../data/FWS_changes.rda")
load("../data/classification_data.rda")

## ----echo=TRUE-----------------------------------------------------------
# Threats and demography by status change
amod <- lm(change$Threat_allev ~ change$status_cat + 0)
summary(amod)

bmod <- lm(change$Improve_demo ~ change$status_cat + 0)
summary(bmod)

cmod <- lm(change$combined_components ~ change$status_cat + 0)
summary(cmod)


## ----echo=TRUE-----------------------------------------------------------
change$status_cat <- relevel(change$status_cat, ref="No Change")
combo_mod <- nnet::multinom(status_cat ~ 0 + combined_components, 
                            data = change,
                            trace = FALSE)
combo_p <- get_multinom_p(combo_mod)
thr_mod <- nnet::multinom(status_cat ~ 0 + Threat_allev, 
                          data = change,
                          trace = FALSE)
thr_p <- get_multinom_p(thr_mod)
demo_mod <- nnet::multinom(status_cat ~ 0 + Improve_demo, 
                           data = change,
                           trace = FALSE)
demo_p <- get_multinom_p(demo_mod)
thr_demo_mod <- nnet::multinom(status_cat ~ 0 + Threat_allev + Improve_demo, 
                               data = change,
                               trace = FALSE)
thr_demo_p <- get_multinom_p(thr_demo_mod)

AICcmodavg::aictab(list(combo_mod, thr_mod, demo_mod, thr_demo_mod))

## ----echo = FALSE--------------------------------------------------------
summary(combo_mod)

# cat(paste0("p-values: ", thr_p[,1]))
cat("p-values:\n")
combo_p

## ----echo = FALSE--------------------------------------------------------
summary(thr_demo_mod)

# cat(paste0("p-values: ", thr_p[,1]))
cat("p-values:\n")
thr_demo_p

## ----echo = FALSE, fig.width=7, fig.align="center"-----------------------
change$tmp_stat_cat <- ifelse(change$status_cat == "Degrade",
                                   "Uplist",
                                   ifelse(change$status_cat == "Improve",
                                          "Down- or de-list",
                                          "No change"))
change$tmp_stat_cat <- as.factor(change$tmp_stat_cat)
change$tmp_stat_cat <- relevel(change$tmp_stat_cat, ref="No change")

aplot <- ggplot(change, aes(tmp_stat_cat, Threat_allev)) +
         geom_boxplot(outlier.shape=NA, alpha=0.5) +
         geom_jitter(alpha=0.3, size=4,
                     position=position_jitter(height=0.05, width=0.5)) +
         labs(x="\nFWS status change recommendation",
              y="",
              title="Threats\n") + 
         theme_minimal(base_size=14) +
         theme(axis.text.x=element_text(vjust=1.5),
               axis.ticks=element_blank(),
               text=element_text(size=14, family="Open Sans"),
               legend.position="none")

bplot <- ggplot(change, aes(tmp_stat_cat, Improve_demo)) +
         geom_boxplot(outlier.shape=NA, alpha=0.5) +
         geom_jitter(alpha=0.3, size=4,
                     position=position_jitter(height=0.05, width=0.4)) +
         labs(x="\n",
              y="",
              title="Demography\n") + 
         theme_minimal(base_size=14) +
         theme(axis.text.x=element_text(vjust=1.5),
               axis.ticks=element_blank(),
               text=element_text(size=14, family="Open Sans"),
               legend.position="none")

cplot <- ggplot(change, aes(tmp_stat_cat, combined_components)) +
         geom_boxplot(outlier.shape=NA, alpha=0.5) +
         geom_jitter(alpha=0.3, size=4,
                     position=position_jitter(height=0.05, width=0.4)) +
         labs(x="\n",
              y="Score",
              title="Threats + Demography\n") + 
         theme_minimal(base_size=14) +
         theme(axis.text.x=element_text(vjust=1.5),
               axis.ticks=element_blank(),
               text=element_text(size=14, family="Open Sans"),
               legend.position="none")
cplot
bplot
aplot

# multiplot(cplot, aplot, bplot, cols=3)

## ----echo = TRUE---------------------------------------------------------
dfa_combo <- MASS::lda(status_cat ~ combined_components,
                       data = change,
                       na.action = "na.omit",
                       CV=TRUE)
combo_comps <- get_lda_comps(change, dfa_combo)

dfa_both <- MASS::lda(status_cat ~ Threat_allev + Improve_demo,
                      data = change,
                      na.action = "na.omit",
                      CV=TRUE)
both_comps <- get_lda_comps(change, dfa_both)

dfa_threat <- MASS::lda(status_cat ~ Threat_allev,
                        data = change,
                        na.action = "na.omit",
                        CV=TRUE)
thr_comps <- get_lda_comps(change, dfa_threat)

dfa_demog <- MASS::lda(status_cat ~ Improve_demo,
                       data = change,
                       na.action = "na.omit",
                       CV=TRUE)
demog_comps <- get_lda_comps(change, dfa_demog)

consists <- c(combo = combo_comps$consistency,
              both = both_comps$consistency,
              threat = thr_comps$consistency,
              demography = demog_comps$consistency)

consists

## ----echo = FALSE--------------------------------------------------------
t(both_comps$marg_tab)

## ----echo = FALSE, fig.align="center", fig.width=7, fig.height=4---------
lda_class$Model <- paste0("Model ", lda_class$Model)
lda_class$Pct_cross <- paste0(lda_class$Pct_cross)

LDA_plot2 <- ggplot(data=lda_class, aes(x=classify, y=N_cross, fill=factor(col))) +
             geom_bar(stat="identity") +
             geom_text(y=26, aes(label=Pct_cross), size=3, colour="gray40") +
             scale_fill_manual(values=c('#0A4783', 'darkolivegreen4', '#f49831'),
                               labels=c("overprotect", "consistent", "underprotect"),
                               name="") +
             facet_grid(Model ~ FWS_rec) +
             ylim(0, 27) +
             labs(x = "\nLDA classification",
                  y = "# species classified\nper FWS x LDA category\n",
                  title = "FWS status change recommendation") +
             theme_bw() +
             theme(text=element_text(size=12, family="Open Sans"),
                   panel.background=element_rect(fill="white"))
LDA_plot2


