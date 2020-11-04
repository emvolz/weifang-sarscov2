invisible('
Combining the log, traj and tree files from the BEAST2 anaylsis with PhyDyn
') 

# Requires:
# The logs, traj and tree files
# The Weifang analysis had 8 of each

# Important! It is crucial to check each MCMC chain to see whether it has converged properly, using Tracer or other programme.
# Although this script should remove poor runs, it is very good practise to check this manually


library( ape ) 
library( ggtree ) 
library ( treeio )


# Make sure you're in the directory with the logs, trajs and trees

setwd("C:/Users/eg1012/Desktop/COVID_simualtions/Weifang10")


###############################################
########### create log and traj files

myLogs <- dir()[grep("xml.log", dir())]
myTrees <- paste(dir()[grep("trees", dir())], collapse=" ")
myTraj <- dir()[grep("xml.traj", dir())]


# This will combine the posterior parameter values (log) and epidemic trajectories (traj)
# The chain with highest posterior probability is automatically included
# The pth is a threshold for rejection/acceptance of the other chains into the combined files
X = combine_logs_and_traj ( logfns = myLogs, 
                            trajfns= myTraj, 
                            burnProportion = .5 , ntraj = 200,
                            ofn = "logs.rds",       
                            ofntraj = "traj.rds",
                            pth = 1/100)     

# Combine tree files

tree_combiner_helper(burnin = 50, fns = NULL, ofn = "combined_trees.trees")

# On a Windows machine it might be easier to specify the path as in the line below
# system("C:/BEAST/bat/logcombiner.bat -log combined_trees.trees Weifang10.1.xml.trees Weifang10.2.xml.trees Weifang10.3.xml.trees Weifang10.4.xml.trees Weifang10.5.xml.trees Weifang10.6.xml.trees Weifang10.7.xml.trees Weifang10.8.xml.trees -b 50 -o combined_trees.trees")

# Make mcc plot
# system("C:/BEAST/bat/treeannotator.bat -limit 0.5 -b 0 -lowMem combined_trees.trees mcc.nex")