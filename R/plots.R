# Plotting functions used in the threat and demography analysis.
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

##############################################################################
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
##############################################################################


#' Create multi-panel plot from individual plots.
#'
#' A simplistic way to create multi-panel ggplot figures when facet won't work.
#' @param ... One or more plot objects to be plotted
#' @param plotlist A list of plots, if not passed as ...
#' @param cols Number of columns the multi-panel plot will have.
#' @param layout An option matrix describing the layout of the multi-panel plot.
#' @return A multi-panel plot composed of the input plots.
#' @seealso The gtable package \url{https://github.com/hadley/gtable} has much
#' more advanced multiplot layout capabilities, but is more complex.
#' @source \url{http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/}
#' @export
#' @examples
#' # plot_a <- qplot(data = dat, geom = "hist")
#' # plot_b <- qplot(data = dat2, x = V1, y = V2, geom = "jitter")
#' # multiplot(plot_a, plot_b, cols = 2)
multiplot <- function(..., plotlist=NULL, cols=1, layout=NULL) {
  plots <- c(list(...), plotlist)
  numPlots = length(plots)

  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }

  if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid::grid.newpage()
    grid::pushViewport(grid::viewport(layout = grid::grid.layout(nrow(layout),
                                                                 ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = grid::viewport(layout.pos.row = matchidx$row,
                                            layout.pos.col = matchidx$col))
    }
  }
}
