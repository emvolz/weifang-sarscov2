invisible('
Compute R0 from parameter posteriors
') 

X <- readRDS( 'data/logs.rds' )
trajdf <- readRDS('data/traj.rds')

gamma1 = 96
tau = 74
ph = 0.20
b2R <- function(b) 
		((1-ph)*b/gamma1 + tau*ph*b/gamma1)

Rs = b2R( X$seir.b )

print( summary( Rs ))
print( quantile( Rs  ,  c(.025, .975) )  )



pl <- SEIJR_reproduction_number(X = X, gamma0 = 89, gamma1 = 96)

pl$table


Rt = SEIJR_plot_Rt(trajdf = trajdf, logdf = X, gamma0 = 89, gamma1 = 96, date_limits = as.Date(c('2019-12-16', '2020-03-10')), 
              path_to_save = "data/R_through_time.pdf", last_tip = as.Date(c('2020-02-10')))
Rt$plot
