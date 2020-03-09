invisible('
Compute R0 from parameter posteriors
') 

X <- readRDS( 'combinedLog.rds' )
gamma1 = 96
tau = 74
ph = 0.20
b2R <- function(b) 
		((1-ph)*b/gamma1 + tau*ph*b/gamma1)

Rs = b2R( X$seir.b )

print( summary( Rs ))
print( quantile( Rs  ,  c(.025, .975) )  )

invisible(
'
ph 20pc: 
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  1.463   1.644   1.846   1.986   2.217   5.447 
    2.5%    97.5% 
1.482970 3.146523 


> print( summary( Rs ))
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  1.018   1.144   1.285   1.382   1.543   3.791 
> print( quantile( Rs  ,  c(.025, .975) )  )
    2.5%    97.5% 
1.032099 2.189878 

'
)

if (FALSE)
{ # run interactively : 
#~ work out what k would be given these parameters 
gamma1 = 96
tau = 74
#~ ph = 0.1350287
ph = 0.20
R = 2 
#~ R = (1-ph) * Rl + ph * tau * Rl -->
Rl = R / ( (1-ph ) + ph * tau  )
v = ( (1-ph)*(Rl+Rl^2) + ph*(tau*Rl + tau^2*Rl^2) )
#~ v = R + R^2 / k -->
k = R^2 / (v - R)
#~ 22%
}
