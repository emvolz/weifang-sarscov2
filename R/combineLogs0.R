invisible('
Combine posterior parameter samples from beast
') 
burnpc = .5 
X <- do.call( rbind, lapply( 1:8, function(i){
	d = read.table( paste0( i,'/seir0.log'), header=TRUE, stringsAsFactors=FALSE) 
	i <- floor( burnpc * nrow(d))
	tail( d, nrow(d) - i )
}))

saveRDS(X , file = 'combinedLog.rds' )
