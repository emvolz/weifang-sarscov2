invisible('
- new mcc tree plot
        - logcombine trees
        - ggtree, colour code weifang, revise tip names, node errbars, time axis
- densitree 
' )
library( ape ) 
library( ggtree ) 



fix_tiplab <- function(x){
	x$tip.label <- sapply( strsplit( x$tip.label , '_' ), '[[', 1 )
	x
}


#~ -------------------------
#~ densitree
if (FALSE)
{
tres <- read.nexus ( 'data/mcc.nex'  )
# tres <- sample( tres, size = 200, replace=FALSE)


# tres <- lapply( tres, fix_tiplab )
dtre <- ggdensitree(tres, alpha=.2, colour='steelblue') +  geom_tiplab(size=3) + theme_tree2() 

ggsave( dtre, file = 'densitree.pdf' )
ggsave( dtre, file = 'densitree.svg' )
}


#~ ----------------
#~ mcc tree
if (FALSE)
{

library( treeio ) 
tr = read.beast ( 'data/mcc.nex' )
btr = ggtree(tr, mrsd="2020-02-10") + geom_range(range='height_0.95_HPD', color='steelblue', alpha=.4, size=4) + theme_tree2() 
tipdata <- data.frame( taxa = treeio::get.tree( tr ) $tip.label, weifang = grepl('WF', treeio::get.tree( tr ) $tip.label) )
tipdata$size <- .25
tipdata$size[ !tipdata$weifang ] <- 0
tipdata$weifang[ !tipdata$weifang ] <- NA
btr <- btr %<+% tipdata 
btr = btr + geom_tippoint( aes(color = weifang, size = size), na.rm=TRUE, show.legend=FALSE, size =1.25) + theme_tree2( legend.position = "none" )
#~ > decimal_date( as.Date( '2020-01-10' ) )
#~ [1] 2020.025

ggsave( btr, file='mcctree.pdf', width = 4, height=7)
ggsave( btr, file='mcctree.svg', width = 4, height=7)
}



#~ -----------------------
#~ TMRCA histogram 
if(FALSE)
{
library( lubridate )

tres <- read.nexus ( 'data/mcc.nex'  )

tr2mrcas <- function(tr)
{
	sts <- sapply( strsplit( tr$tip.label , '[|]' ), function(x) as.numeric( tail(x,2)[1] ))
	maxsts = max(sts )
	wftips <- tr$tip.label [ grepl(tr$tip.label , pattern='WF')  ]
	wfmrca = getMRCA( tr, wftips )
	nel <- node.depth.edgelength( tr )
	mnel = max(nel )
	x1 = date_decimal( maxsts - ( mnel - nel [ wfmrca ] ) )
	
	inodes = (Ntip(tr)+1):(Ntip(tr)+Nnode(tr))
	X = c()
	for (u in inodes){
		tr1 = extract.clade( tr, node = u )
		X <- rbind( X, 
		  c( u, Ntip(tr1), all (tr1$tip.label %in% wftips) )
		)
	}
	X1 <- X[ X[,3] ==1 , ]
	ustar = X1[ which.max( X1[,2] ) , 1]
	x2 = date_decimal( maxsts - ( mnel - nel [ ustar ] ) )
	print( c( x1, x2 ))
	c( x1, x2 )
}

X = tr2mrcas(tres)
X1 = do.call( c, lapply( X, '[[', 1 ))
X2 = do.call( c, lapply( X, '[[', 2 ))


library( ggplot2 ) 
pldf <- data.frame( wftmrca = X1 )
pl = ggplot(pldf, aes(wftmrca, fill = TRUE)) + geom_density(alpha = 0.2, fill = 'blue', show.legend=FALSE) + theme_bw()  + xlab('Weifang TMRCA') + ylab('')
ggsave( pl, file='wftmrca2.pdf', width = 3.5, height = 2.8 )
ggsave( pl, file='wftmrca2.svg', width = 3.5, height = 2.8 )
}
