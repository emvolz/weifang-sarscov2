invisible('
This script will calculate prior R from the main analysis parameterisation, and dispersion in offspring heterogeneity
') 

# parameters
gamma1 = 96
tau = 74
ph = 0.20


# R is a weighted average of beta/gamma for I and J
b2R <- function(b) 
  ((1-ph)*b/gamma1 + tau*ph*b/gamma1)

# the variance in offspring distribution is a function of mixed geometric distributions for I and J separately
b2sigma <- function ( b, nr = 1e5 ){
  Rl <- b/gamma1
  Rh <- tau*b/gamma1
  yl <- rgeom( floor(nr*(1-ph)), 1/(Rl+1) )
  yh <- rgeom( floor(nr*ph), 1/(Rh+1) )
  sd( c( yl, yh ))
}

# the variance in offspring distribution is made equal to a negative binomial distribution (R(1+R/k)).
# Solving for k is the following funcction
sigma2k <- function(sigma, R) {
  R^2 / ( sigma^2 - R )
}


# distribution of beta given the prior lognormal distribution
quantile(rlnorm(100000, meanlog = 3.21, sdlog = 0.5))

# distribution of R when sampling from b prior
quantile(b2R(b = rlnorm(100000, meanlog = 3.21, sdlog = 0.5)))

# plotting distribution of R
hist(b2R(b = rlnorm(100000, meanlog = 3.21, sdlog = 0.5)), breaks = 1000, xlim = c(0,10))


# k is insensitive to R
R = 4
(b2 <- optimise( f = function(b) (b2R(b)-R)^2 , lower = 1, upper = 1e3, maximum = F)$minimum )
(s2 <- b2sigma( b2,nr =5e6 ))
(k <- sigma2k( s2, R ) )
R = 5
(b2 <- optimise( f = function(b) (b2R(b)-R)^2 , lower = 1, upper = 1e3, maximum = F)$minimum )
(s2 <- b2sigma( b2,nr =5e6 ))
(k <- sigma2k( s2, R ) )
R = 3
(b2 <- optimise( f = function(b) (b2R(b)-R)^2 , lower = 1, upper = 1e3, maximum = F)$minimum )
(s2 <- b2sigma( b2,nr =5e6 ))
(k <- sigma2k( s2, R ) )
R = 2
(b2 <- optimise( f = function(b) (b2R(b)-R)^2 , lower = 1, upper = 1e3, maximum = F)$minimum )
(s2 <- b2sigma( b2,nr =5e6 ))
(k <- sigma2k( s2, R ) )
# k is about 12.5%

# so to increase k to 20% we need to decrease tau

# 13 is the value which leads k to 20%
tau = 13

R=4

b2 <- optimise( f = function(b) (b2R(b)-R)^2 , lower = 1, upper = 1e3, maximum = F)$minimum 
s2 <- b2sigma( b2,nr =5e6 )
(k <- sigma2k( s2, R ) *100)


# and so to retrieve R=4 i need to increase the prior on b to as follows:
mean(b2R(b = rlnorm(100000, meanlog = 4.61, sdlog = 0.5)))

