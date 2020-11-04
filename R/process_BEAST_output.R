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

###############################################
########### create log and traj files

myFiles <- dir()[grep(fileName, dir())]
myLogs <- myFiles[grep("xml.log", myFiles)]
myTrees <- paste(myFiles[grep("trees", myFiles)], collapse=" ")
myTraj <-myFiles[grep("xml.traj", myFiles)]



X = combine_logs_and_traj ( logfns = myLogs, 
                            trajfns= myTraj, 
                            burnProportion = .5 , ntraj = 200,
                            ofn = "logs.rds",       
                            ofntraj = "traj.rds",
                            pth = 1/100)     



# setwd(paste0(getwd(), "/best"))

tree_combiner_helper <- function( burnin=50 , fns = NULL, ofn = 'combined.trees'){
  if ( is.null( fns )) {
    fns = list.files(pattern='trees$')[X$keep]
    if(any(grep("combined", fns)))
      cat ("WARNING: combined tree?")
  }
  cat( 'NOTE: these tree logs are being combined. Double check that these are the files you want to combine\n' )
  print( fns )
  # browser()
  command = paste( "C:/Users/eg1012/Downloads/BEAST_with_JRE.v2.6.2.Windows/BEAST/bat/logcombiner.bat", "-log",  paste(fns, collapse=" "),
                   "-b 50 -o", ofn, "-resample 50000")
  print ( command ) 
  system (command) 
  #system(paste("C:/Users/mr909/Downloads/BEAST.v2.6.2/bat/logcombiner.bat -log", myTrees, "-b 50 -o", ofn))
  TRUE
}

# combine tree files

combinedName <- paste0("best/", fileName, "_combined.trees")
tree_combiner_helper(  ofn=combinedName)


# make mcc plot


command = paste( "C:/Users/eg1012/Downloads/BEAST_with_JRE.v2.6.2.Windows/BEAST/bat/treeannotator.bat -limit 0.5 -b 0 -lowMem", combinedName, "best/mcc.nex")
# paste(fileName, "mcc.nex", sep="_"))
print ( command ) 
system (command) 


gc()


###############################################
########### print info for yaml file

# fileName <- "Sweden"
# 
# analysis_number <-6
setwd(paste0("C:/Users/eg1012/Desktop/COVID_simualtions/", fileName, analysis_number))

if(metadata_create) {
  
  
  
  
  ymlInfo <- function(fileName){
    if(file.exists(paste0("C:/Users/eg1012/Desktop/Upload_to_HPC/", fileName, analysis_number, "/",fileName, analysis_number, "_GDclean.fas"))) {
      fasta <- ape::read.dna(paste0("C:/Users/eg1012/Desktop/Upload_to_HPC/", fileName, analysis_number, "/",fileName, analysis_number, "_GDclean.fas"), format="fasta", as.matrix = TRUE)
    } else {
      d <- list.files("C:/Users/eg1012/Desktop/Upload_to_HPC/")[grep(fileName, list.files("C:/Users/eg1012/Desktop/Upload_to_HPC/"))]
      d <- tail(sort(d), 1)
      
      fasta <- ape::read.dna(paste0("C:/Users/eg1012/Desktop/Upload_to_HPC/", d, "/", d, "_GDclean.fas"), format="fasta", as.matrix = TRUE)
    }
    dates <- as.Date(unlist(lapply(rownames(fasta), function(x) {strsplit(x, "\\|")[[1]][3]})))
    
    localSeq <- rownames(fasta)[grep("_Il", rownames(fasta))]
    localDates <- as.Date(unlist(lapply(localSeq, function(x) {strsplit(x, "\\|")[[1]][3]})))
    nExogSeq <- length(grep("_exog", rownames(fasta)))
    
    
    print(fileName)
    print(paste("Number of local samples:", length(localSeq)))
    print(paste("Number of exog samples:", nExogSeq))
    print(paste("First local sample:", min(localDates)))
    print(paste("Last local sample:", max(localDates)))
    print(paste("plot date start:", min(dates)-14))
    print(paste("plot date end:", max(dates)+14))
    
    
    return(list(localSeq = length(localSeq),
                pnExogSeq = nExogSeq,
                localDates_min = min(localDates),
                localDates_max = max(localDates),
                plotstartdate = min(dates)-14,
                plotenddate = max(dates)+14
    ))
    
  }
  
  ymlInfo_print <- ymlInfo(fileName)
  
  
  
  # "Sweden"
  
  write_phylo_metadata_yaml(location = fileName,
                            # sequence_downsampling = "Deduplicated",
                            model_version = "seijr0.1.3",
                            internal_seq = ymlInfo_print$localSeq,
                            exog_seq = ymlInfo_print$pnExogSeq,
                            first_sample = as.character(ymlInfo_print$localDates_min),
                            last_sample = as.character(ymlInfo_print$localDates_max),
                            start_date = as.character(ymlInfo_print$plotstartdate),
                            end_date = as.character(ymlInfo_print$plotenddate)
  )
  file.copy("metadata.yml", "best/metadata.yml")
  fileName
  ymlInfo_print
  
}





# "Minnesota"

# write_phylo_metadata_yaml(location = fileName,
#                           # sequence_downsampling = "Deduplicated",
#                           model_version = "seeding-0.0.1",
#                           internal_seq = ymlInfo_print$localSeq,
#                           exog_seq = ymlInfo_print$pnExogSeq,
#                           first_sample = as.character(ymlInfo_print$localDates_min),
#                           last_sample = as.character(ymlInfo_print$localDates_max),
#                           start_date = as.character(ymlInfo_print$plotstartdate),
#                           end_date = as.character(ymlInfo_print$plotenddate),
#                           school_closure_date = '2020-03-18',
#                           lockdown_date = '2020-03-28'
# )
# file.copy("metadata.yml", "best/metadata.yml")


# WISCONSIN

# write_phylo_metadata_yaml(location = fileName,
#                           # sequence_downsampling = "Deduplicated",
#                           model_version = "seeding-0.0.1",
#                           internal_seq = ymlInfo_print$localSeq,
#                           exog_seq = ymlInfo_print$pnExogSeq,
#                           first_sample = as.character(ymlInfo_print$localDates_min),
#                           last_sample = as.character(ymlInfo_print$localDates_max),
#                           start_date = as.character(ymlInfo_print$plotstartdate), 
#                           end_date = as.character(ymlInfo_print$plotenddate),
#                           school_closure_date = '2020-03-18',
#                           lockdown_date = '2020-03-25'
# )
# file.copy("metadata.yml", "best/metadata.yml")

list.dirs()




run_analysis(fileName = "Vaud", analysis_number = "3weeksbefore", treestuff = T, create_report_folder = T)
run_analysis(fileName = "Vaud", analysis_number = "2weeksbefore", treestuff = T, create_report_folder = T)
run_analysis(fileName = "Vaud", analysis_number = "1weekbefore", treestuff = T, create_report_folder = T)
run_analysis(fileName = "Vaud", analysis_number = "onetheday", treestuff = T, create_report_folder = T)

run_analysis(fileName = "Zurich", analysis_number = "3_weeks_before", treestuff = T, create_report_folder = T)
run_analysis(fileName = "Zurich", analysis_number = "2_weeks_before", treestuff = T, create_report_folder = T)
run_analysis(fileName = "Zurich", analysis_number = "1_week_before", treestuff = T, create_report_folder = T)
run_analysis(fileName = "Zurich", analysis_number = "on_the_day", treestuff = T, create_report_folder = T)

run_analysis(fileName = "Geneva", analysis_number = "3weeksbefore", treestuff = T, create_report_folder = T)
run_analysis(fileName = "Geneva", analysis_number = "2weeksbefore", treestuff = T, create_report_folder = T)
run_analysis(fileName = "Geneva", analysis_number = "1weekbefore", treestuff = T, create_report_folder = T)
run_analysis(fileName = "Geneva", analysis_number = "ontheday", treestuff = T, create_report_folder = T)



run_analysis(fileName = "Wisconsin", analysis_number = "3", treestuff = T, create_report_folder = T)


run_analysis(fileName = "Wisconsin", analysis_number = "11", treestuff = T, create_report_folder = T)
run_analysis(fileName = "Victoria", analysis_number = "9", treestuff = T, create_report_folder = T)
run_analysis(fileName = "Switzerland", analysis_number = "10", treestuff = T, create_report_folder = T)
run_analysis(fileName = "Sweden", analysis_number = "15", treestuff = T, create_report_folder = T)
run_analysis(fileName = "Basel", analysis_number = "1", treestuff = T, create_report_folder = T)



run_analysis(fileName = "Switzerland", analysis_number = "11", treestuff = T, create_report_folder = T)


run_analysis(fileName = "Stockholm", analysis_number = "1", treestuff = T, create_report_folder = T)
run_analysis(fileName = "Stockholm", analysis_number = "2", treestuff = T, create_report_folder = T)



run_analysis(fileName = "Weifang", analysis_number = "4", treestuff = T, create_report_folder = T, metadata_create = F)
run_analysis(fileName = "Weifang", analysis_number = "5", treestuff = T, create_report_folder = T, metadata_create = F)
run_analysis(fileName = "Weifang_prior", analysis_number = "4", treestuff = T, create_report_folder = T, metadata_create = F)
run_analysis(fileName = "Weifang_prior", analysis_number = "5", treestuff = T, create_report_folder = T, metadata_create = F)



run_analysis(fileName = "Weifang", analysis_number = "6", treestuff = T, create_report_folder = T, metadata_create = F)
run_analysis(fileName = "Weifang", analysis_number = "7", treestuff = T, create_report_folder = T, metadata_create = F)
run_analysis(fileName = "Weifang_prior", analysis_number = "6", treestuff = T, create_report_folder = T, metadata_create = F)
run_analysis(fileName = "Weifang_prior", analysis_number = "7", treestuff = T, create_report_folder = T, metadata_create = F)

run_analysis(fileName = "Weifang", analysis_number = "8", treestuff = T, create_report_folder = T, metadata_create = F)
run_analysis(fileName = "Weifang_prior", analysis_number = "8", treestuff = T, create_report_folder = T, metadata_create = F)


# I did metadata_create =F because if T it made metadata.yml with wrong gammas
run_analysis(fileName = "Weifang", analysis_number = "10", treestuff = T, create_report_folder = T, metadata_create =F)
run_analysis(fileName = "Weifang_prior", analysis_number = "10", treestuff = T, create_report_folder = T, metadata_create = F)
run_analysis(fileName = "Weifang", analysis_number = "11", treestuff = T, create_report_folder = T, metadata_create = F)
run_analysis(fileName = "Weifang_prior", analysis_number = "11", treestuff = T, create_report_folder = T, metadata_create = F)
run_analysis(fileName = "Weifang", analysis_number = "13", treestuff = T, create_report_folder = T, metadata_create = F)
run_analysis(fileName = "Weifang_prior", analysis_number = "13", treestuff = T, create_report_folder = T, metadata_create = F)
