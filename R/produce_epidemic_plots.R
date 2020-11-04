invisible('
Producing the epidemic plots in Weifang') 

# Requires:
# The combined log and traj

invisible('
Plot infections through time 
          ') 
library( ggplot2 ) 
library( lubridate )

readRDS('data/traj.rds') -> trajdf 
r <- read.csv( 'data/reportedcases.csv', header=TRUE , stringsAsFactors=FALSE)
r$Date <- as.Date( r$Date )
r$reported = TRUE
r$`Cumulative confirmed` = r$Cumulative.confirmed.cases

dfs <- split( trajdf, trajdf$Sample )
taxis <- dfs[[1]]$t 

qs <- c( .5, .025, .975 )

# infectious
Il = do.call( cbind, lapply( dfs, '[[', 'Il' ))
Ih = do.call( cbind, lapply( dfs, '[[', 'Ih' ))
I = Il + Ih 
t(apply( I, MAR=1, FUN= function(x) quantile(x, qs ))) -> Ici 

# cases 
cases <- do.call( cbind, lapply( dfs, '[[', 'infections' ))
t(apply( cases, MAR=1, FUN=function(x) quantile(x,qs))) -> casesci 

#exog 
exog <- do.call( cbind, lapply( dfs, '[[', 'exog' ))
t(apply( exog, MAR=1, FUN=function(x) quantile(x, qs )	)) -> exogci 


#exog 
E <- do.call( cbind, lapply( dfs, '[[', 'E' ))
t(apply( E, MAR=1, FUN=function(x) quantile(x, qs )	)) -> Eci 


#~ ------------
pldf <- data.frame( Date = ( date_decimal( taxis ) ) , reported=FALSE )
pldf$`Cumulative infections` = casesci[,1]
pldf$`2.5%` = casesci[,2]
pldf$`97.5%` = casesci[,3] 
pldf <- merge( pldf, r , all = TRUE ) 
pldf <- pldf[ with( pldf, Date > as.Date('2020-01-10') & Date < as.Date('2020-02-21') ) , ]
pl = ggplot( pldf ) + geom_point( aes( x=Date, y = `Cumulative confirmed` ) ) + geom_path( aes(x = Date, y = `Cumulative infections` , group = !reported), lwd=1.25) + geom_ribbon( aes(x = Date, ymin=`2.5%`, ymax=`97.5%`, group = !reported) , alpha = .25 ) 
pl <- pl + theme_minimal()  + xlab('') + 
  ylab ('Cumulative estimated infections (ribbon) 
 Cumulative confirmed (points)') 

ggsave(pl, file = 'cumulative_infections.pdf', width = 3.6, height = 3.25, dpi = 600)
