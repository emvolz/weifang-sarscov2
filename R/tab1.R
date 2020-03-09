invisible('
Making table 1 

% latex table generated in R 3.6.3 by xtable 1.8-4 package
% Sat Mar  7 18:36:41 2020
\begin{table}[ht]
\centering
\begin{tabular}{}
  \hline
 & Parameter & Prior & Posterior.mean & Posterior.95..HPD \\ 
  \hline
1 & Initial infected & Exponential(mean=1) & 2.3 & 0.18-6.9 \\ 
  2 & Initial susceptible & Log-normal(mean log=6, sd log=1) & 787 & 102-3235 \\ 
  3 & Migration rate & Exponential(mean=10*) & 1.67 & 0.96-2.0 \\ 
  4 & Reproduction number & Log-normal(mean log=1.03, sd log =0.5) & 1.38 & 1.03-2.19 \\ 
  5 & Molecular clock rate & Uniform(0.0007,0.003) & 0.0028 & 0.0024-0.003 \\ 
  6 & Transition/transversion & Log-normal(mean log=1,sd log=1.25) & 7.0 & 4.4-11.1 \\ 
  7 & Gamma shape & Exponential(mean=1) & 0.05 & 0.003-0.12 \\ 
   \hline
\end{tabular}
\end{table}
')

library( xtable ) 

if (FALSE)
{ # do this stuff interactively: 
gamma1 = 96
tau = 74
ph = 0.1350287
r0x = (1-ph) + tau*ph
logbeff = 3.21 + log( r0x  )
	
	exp( logbeff ) / gamma1
	qlnorm(.025,  meanlog= logbeff  + log(1/gamma1), sdlog = .5 ) # <- dist of R0 also lognormal 
	9.125967 * r0x / gamma1
	19.363216 * r0x / gamma1
	11.361824 * r0x / gamma1
	12.22 * r0x / gamma1
}


X <- readRDS( 'combinedLog.rds' )
#~ > sapply( X, function(x) quantile( x, c(.5, .025, .975) ) )
#~         Sample posterior likelihood    prior treeLikelihood.algn1 TreeHeight
#~ 50%   10414000 -41566.51  -41617.80 51.89670            -41617.80  0.1602637
#~ 2.5%   7108600 -41583.81  -41636.85 37.36142            -41636.85  0.1491686
#~ 97.5% 13740000 -41549.66  -41608.51 76.76740            -41608.51  0.1857702
#~         clockRate  gammaShape     kappa freqParameter.1 freqParameter.2
#~ 50%   0.002890389 0.043303304  6.779479       0.2986605       0.1835749
#~ 2.5%  0.002472106 0.003144315  4.300695       0.2936126       0.1792102
#~ 97.5% 0.002996027 0.120635855 11.125360       0.3038309       0.1880221
#~       freqParameter.3 freqParameter.4 PhydynSEIR    seir.E    seir.S    seir.b
#~ 50%         0.1957073       0.3220139   74.32358 1.9755296  508.2102 11.361824
#~ 2.5%        0.1912504       0.3167273   59.03620 0.1766815  101.8727  9.125967
#~ 97.5%       0.2003178       0.3272289  100.02848 6.9480533 3235.3532 19.363216
#~         seir.exog seir.exogGrowthRate seir.importRate
#~ 50%   1.000530251            16.03578       1.7450643
#~ 2.5%  0.008276044            11.43160       0.9576239
#~ 97.5% 1.990721875            22.59593       1.9902542

#~ > sapply( X, mean )
#~               Sample            posterior           likelihood 
#~         1.041677e+07        -4.156662e+04        -4.161985e+04 
#~                prior treeLikelihood.algn1           TreeHeight 
#~         5.323359e+01        -4.161985e+04         1.624117e-01 
#~            clockRate           gammaShape                kappa 
#~         2.848733e-03         4.776489e-02         7.020933e+00 
#~      freqParameter.1      freqParameter.2      freqParameter.3 
#~         2.986773e-01         1.836038e-01         1.957247e-01 
#~      freqParameter.4           PhydynSEIR               seir.E 
#~         3.219941e-01         7.579418e+01         2.308445e+00 
#~               seir.S               seir.b            seir.exog 
#~         7.868955e+02         1.222312e+01         1.000054e+00 
#~  seir.exogGrowthRate      seir.importRate 
#~         1.628376e+01         1.670456e+00 


data.frame( 
Parameter = c('Initial infected', 'Initial susceptible', 'Migration rate', 'Reproduction number', 'Molecular clock rate', 'Transition/transversion', 'Gamma shape') 
, Prior = c('Exponential(mean=1)' , 'Log-normal(mean log=6, sd log=1)', 'Exponential(mean=10*)', 'Log-normal(mean log=1.03, sd log =0.5)' , 'Uniform(0.0007,0.003)','Log-normal(mean log=1,sd log=1.25)' , 'Exponential(mean=1)')
, `Posterior mean`=c('2.3','787','1.67','1.38','0.0028','7.0','0.05')
, `Posterior 95% HPD` = c('0.18-6.9', '102-3235', '0.96-2.0', '1.03-2.19', '0.0024-0.003', '4.4-11.1', '0.003-0.12')
) -> y 




print( xtable::toLatex.xtable( y ) )
invisible('
% latex table generated in R 3.6.3 by xtable 1.8-4 package
% Sat Mar  7 18:36:41 2020
\begin{table}[ht]
\centering
\begin{tabular}{}
  \hline
 & Parameter & Prior & Posterior.mean & Posterior.95..HPD \\ 
  \hline
1 & Initial infected & Exponential(mean=1) & 2.3 & 0.18-6.9 \\ 
  2 & Initial susceptible & Log-normal(mean log=6, sd log=1) & 787 & 102-3235 \\ 
  3 & Migration rate & Exponential(mean=10*) & 1.67 & 0.96-2.0 \\ 
  4 & Reproduction number & Log-normal(mean log=1.03, sd log =0.5) & 1.38 & 1.03-2.19 \\ 
  5 & Molecular clock rate & Uniform(0.0007,0.003) & 0.0028 & 0.0024-0.003 \\ 
  6 & Transition/transversion & Log-normal(mean log=1,sd log=1.25) & 7.0 & 4.4-11.1 \\ 
  7 & Gamma shape & Exponential(mean=1) & 0.05 & 0.003-0.12 \\ 
   \hline
\end{tabular}
\end{table}
')

