invisible('
Compute R0 from parameter posteriors
') 

X <- readRDS( 'data/logs.rds' )
gamma1 = 96
tau = 74
ph = 0.20
b2R <- function(b) 
		((1-ph)*b/gamma1 + tau*ph*b/gamma1)

Rs = b2R( X$seir.b )

print( summary( Rs ))
print( quantile( Rs  ,  c(.025, .975) )  )



