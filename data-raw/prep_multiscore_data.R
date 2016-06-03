# Prep the multi-person FL spp. scoring data.
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

multi <- readxl::read_excel("data-raw/FL_scores_multi.xlsx")
multi <- multi[, 1:4]
head(multi)
dim(multi)
multi$Threat <- as.numeric(multi$Threat)
multi$Demography <- as.numeric(multi$Demography)

save(multi, file = "data/FL_scores_multi.rda")
