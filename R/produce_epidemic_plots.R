invisible('
Producing the epidemic plots in Weifang') 

# Requires:
# The combined log and traj

invisible('
Plot infections through time 
          ') 
library( ggplot2 ) 
library( lubridate )
library( scales )

# Reading in combined logs and traj files
X <- readRDS( 'data/logs.rds' )
trajdf <- readRDS('data/traj.rds')

# Cumulative infections
infections <- SEIJR_plot_size(trajdf = trajdf, logdf = X, date_limits = as.Date(c('2019-12-16', '2020-03-10')), logscale = T,
                path_to_save = "data/cumulative_infections_through_time.pdf", last_tip = as.Date(c('2020-02-10')))

# Daily infections
infections_daily <- SEIJR_plot_daily_inf(trajdf = trajdf, logdf = X, date_limits = as.Date(c('2019-12-16', '2020-03-10')), 
                              path_to_save = "data/daily_infections_through_time.pdf", last_tip = as.Date(c('2020-02-10')))



