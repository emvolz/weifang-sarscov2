invisible('
Define appropriate subset and add metadata 
for Weifang sequences: 21.fasta 
') 
library( ape ) 
library( seqinr )
dshandong <- read.fasta( '21.fas' )
d = read.fasta( 'algn.21.0.fasta')
drop <- 'EP402125' 
#~ keep <- sapply( strsplit( read.tree( 'a5alltrees1.nwk' )$tip.label , split='_' ), function(x) x[[1]] )
keep <- paste0( read.tree( 'a5alltrees1.nwk' )$tip.label, '_Il' )
keep <- c( keep, setdiff( names(dshandong ), drop ) )

d1 <- d[ keep ]
d1 <- d1[ !is.na(names(d1)) ]


# get dates
stsdf0ns <- read.csv( 'a5alltrees1.csv' , stringsAsFactors=FALSE )
stsns <- setNames( stsdf0ns$date, stsdf0ns$tip )
datesdf <- read.table( '20.date.txt', header=FALSE, stringsAsFactors=F )
library( lubridate ) 
stsDate <- setNames( ymd(datesdf[,2] ) , datesdf[,1] )
sts <- decimal_date( stsDate )
sts <- c( sts, EP402125 = decimal_date( as.Date('2019-12-31')) )
sts <- c( sts, stsns )

# fix names; insert date; remove il; add exog/il for beast
d2 = d1 
i <- grepl( names(d2), pattern = '_Il' )
names(d2)[ i ] <- sapply( strsplit( split='_', names(d2)[i] ), function(x) x[[1]] )
isshandong <- grepl( 'WFCDC', names(d2 ) )
isexog <- !isshandong 
names(d2) <- paste( sep = '_', names(d2) , sts [ names(d2) ] )
names(d2)[isexog] <- paste( sep = '_', names(d2)[isexog], 'exog' )
names(d2)[isshandong] <- paste( sep = '_', names(d2)[isshandong], 'Il' )

#out
write.fasta( d2, names(d2), 'algn.21.1.fasta')
