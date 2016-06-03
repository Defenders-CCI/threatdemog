## ----setup, include=FALSE------------------------------------------------
library(ggplot2)
library(ggthemes)
library(ICC)
library(pastecs)
library(threatdemog)
library(viridis)

# load("data/FL_scores_all.rda")
# load("data/FL_scores_multi.rda")
load("../data/FL_scores_all.rda")
load("../data/FL_scores_multi.rda")

## ----echo=TRUE-----------------------------------------------------------
summary_all <- stat.desc(FL_all)
summary_all <- t(summary_all[c(1,3,4,5,8:11,13), c(-4,-1)])
summary_all <- data.frame(summary_all)
names(summary_all) <- c("n", "N/A", "min", "max", "median", "mean", "s.e.", 
                        "95% CI", "s.d.")
summary_all


## ----echo = FALSE--------------------------------------------------------
cat("Threat scores:\n")
tapply(FL_all$Threat,
       INDEX = FL_all$Recommendation,
       FUN = mean, na.rm = T)
table(FL_all$Threat, FL_all$Recommendation)

cat("Demography scores:\n")
tapply(FL_all$Demography,
       INDEX = FL_all$Recommendation,
       FUN = mean, na.rm = T)
table(FL_all$Demography, FL_all$Recommendation)

## ----echo = FALSE--------------------------------------------------------
cat("Correlation between threat and demography scores:\n")
cor.test(FL_all$Threat, FL_all$Demography, use = "complete")

## ----echo = FALSE--------------------------------------------------------
ggplot(data = FL_all, aes(x = Threat, y = Demography)) +
    geom_jitter(height = 0.2, width = 0.2, size = 4, alpha = 0.3) +
    geom_vline(xintercept = 0, color = "red", alpha = 0.5) +
    geom_hline(yintercept = 0, color = "red", alpha = 0.5) +
    theme_hc()

## ----echo = FALSE--------------------------------------------------------
summary_mult <- stat.desc(multi)
summary_mult <- t(summary_mult[c(1,3,4,5,8:11,13),c(-2,-1)])
summary_mult <- data.frame(summary_mult)
names(summary_mult) <- c("n", "N/A", "min", "max", "median", "mean", "s.e.", 
                        "95% CI", "s.d.")
summary_mult

## ----echo = TRUE---------------------------------------------------------
th_m1 <- lm(Threat ~ Person + Species, data = multi)
anova(th_m1)
summary(th_m1)
qplot(resid(th_m1), 
      geom = "histogram", 
      xlab = "Residuals",
      bins = 5) + theme_hc()

ICC_thr <- ICCest(x = Species, y = Threat, data = multi)
ICC_thr

## ----echo = TRUE---------------------------------------------------------
dem_m1 <- lm(Demography ~ Person + Species, data = multi)
anova(dem_m1)
summary(dem_m1)
qplot(resid(dem_m1), 
      geom = "histogram", 
      xlab = "Residuals",
      bins = 5) + theme_hc()

ICC_thr <- ICCest(x = Species, y = Demography, data = multi)
ICC_thr

## ----echo = FALSE, fig.width = 8, fig.height = 6-------------------------
tmp <- data.frame(species = c(multi$Species, multi$Species),
                  person = c(multi$Person, multi$Person),
                  category = c(rep("Threat", length(multi$Person)),
                               rep("Demography", length(multi$Person))),
                  score = c(multi$Threat, multi$Demography))

var_plot <- ggplot(data = tmp, aes(x = species, y = score)) +
                geom_violin(fill = "gray87", colour = "gray87") +
                geom_jitter(height = 0.05,
                            width = 0.4,
                            size = 3,
                            alpha = 0.8,
                            aes(colour = person)) +
                facet_grid(. ~ category) +
                scale_color_viridis(discrete = TRUE) +
                coord_flip() +
                labs(x = "", y = "\nScore\n") +
                theme_hc() +
                theme(axis.text.y = element_text(size = 8))
var_plot

