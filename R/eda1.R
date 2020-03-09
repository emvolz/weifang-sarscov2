invisible('
Exploratory data analysis with treedater 
for Weifang sequences: 21.fas
') 

library( ape ) 

d <- read.dna( '21.fas', format = 'fasta' )
raw <- dist.dna( d, model = 'raw' ) 
hky <- dist.dna( d, model = 'f84' )

.raw <- as.matrix( raw )
diag(.raw) <- NA 
print( mean( na.omit(as.vector(  .raw )) ) * 29855 )
#~ 3.27

tr <- read.tree( 'algn.21.1.fasta.treefile' )
library( lubridate ) 
library( treedater )
sts <- sapply( strsplit( tr$tip.label, '_' ), function(x)  as.numeric(x[length(x)-1] ) )
names(sts ) <- tr$tip.label
td = dater( tr, sts, s = 29e3 , meanRateLimits = c(.0007, .0015) )

pdf('shandong-treedater-21.pdf')
plot( td ); axisPhylo(root.time = 2020, backward=FALSE)
dev.off() 

pdf('shandong-rtt-21.pdf')
rootToTipRegressionPlot( td , bty='n')
dev.off() 

ot0 = outlierTips( td ) 
invisible('
                                                                              taxon
Wuhan_HBCDC-HB-01_2019_2019.99452054795_exog Wuhan_HBCDC-HB-01_2019_2019.99452054795_exog
USA_CA1_2020_2020.06010928962_exog                     USA_CA1_2020_2020.06010928962_exog
                                                       q            p loglik
Wuhan_HBCDC-HB-01_2019_2019.99452054795_exog 0.001622632 3.061569e-05     NA
USA_CA1_2020_2020.06010928962_exog           0.025098181 9.471012e-04     NA
                                                   rates branch.length
Wuhan_HBCDC-HB-01_2019_2019.99452054795_exog 0.000772136  0.0002475612
USA_CA1_2020_2020.06010928962_exog           0.000772136  0.0427436814
> 

')
dd = read.dna( 'algn.21.1.fasta' , format ='fasta')
toremove <- c( 'Wuhan_HBCDC-HB-01_2019_2019.99452054795_exog', 'USA_CA1_2020_2020.06010928962_exog' )
dd <- dd[ setdiff( rownames(dd), toremove ), ]
write.dna(dd,  'algn.21.2.fasta', format = 'fasta' )
