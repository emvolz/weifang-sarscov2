invisible('
Combine posterior sample model trajectories from beast:phydyn

') 
ntraj <- floor( 500 / 8 ) # take this many from each 
burnpc = .5 

X <- do.call( rbind, lapply( 1:8, function(i){
	d = read.table( paste0(i, '/seir0.traj' ), header=TRUE, stringsAsFactors=FALSE)
	ids = sort (unique( d$Sample ))
	keep <- sample( tail(ids, floor(length(ids)-burnpc*length(ids)))
	 , size = ntraj, replace=FALSE)
	d = d[ d$Sample %in% keep , ]
	d$Sample <- paste0( as.character(d$Sample) , '.', i)
	d
	
}))


saveRDS( X, file = 'combineTraj0.rds' )
