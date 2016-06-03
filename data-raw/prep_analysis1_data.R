# Prepare data from analysis 1.
# Copyright (c) 2016 Defenders of Wildlife, jmalcom@defenders.org

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.
#

fil <- "data-raw/RecoveryActs_near-final.tab"

dat <- read.table(fil,
                  sep="\t",
                  header=TRUE,
                  stringsAsFactors=FALSE)

dat$priority_conflict <- ifelse(dat$priority_conflict == "",
                                "NC",
                                dat$priority_conflict)

to_factor <- c(1, 2, 14, 25, 27)
for (i in to_factor) {
  dat[,i] <- as.factor(dat[,i])
}

to_numeric <- c(3:13)
for (i in to_numeric) {
  dat[,i] <- as.numeric(dat[,i])
}

to_date <- c(15, 16, 17)
for (i in to_date) {
  dat[,i] <- as.Date(dat[,i], format="%m/%d/%y")
}

dat <- dat[,c(1:25, 27)]
dat$combined_components <- dat$Threat_allev + dat$Improve_demo

change <- dat[, c(1, 12:17, 21:26)]
change <- dplyr::distinct(change)

save(change, file = "data/FWS_changes.rda")

