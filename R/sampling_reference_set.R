

# sarscov2Rutils package required: https://github.com/emvolz-phylodynamics/sarscov2Rutils

# devtools::install_github("emvolz-phylodynamics/sarscov2Rutils", ref = 'sarscov2Rutils')



# GISAID database and metadata required: gisaid.org.
# place these files in a /data folder

require(ape)
library(lubridate)
require(sarscov2)


# Reading in  database
fn = read.dna("data/gisaid_db.fas", format = 'fasta' ) ## path to the GISAID alignment: 
md <- read.csv( "data/md.csv", stringsAs = FALSE ) # Load the metadata
xml_skelly <- paste0('beast/seir.xml' ) # skeleton for xml


# Checking my sequences feature in the metadata
table(unlist(lapply(strsplit(rownames(fn), "[|]"), function(x) x[[2]])) %in% md$gisaid_epi_isl)



# Sampling internal and exogenous sequences.
# Here specifying 50 internal and exogenous sequences; there are only 20 sequences from Weifang so they will all be chosen.
# Note that the function will retrieve not only reference 50 sequences sampled through time, but also close genetic matches to the internal Weifang sequences. 
# This will mean the reference set will be larger than 50.
# If available, a distance matrix D can speed this up
sarscov2::region_time_stratified_sample(region_regex = "WF", path_to_align = fn, D=NULL, nregion = 50, n = 50, path_to_save = "algn.fas")

# This is the output alignment: "algn.fas"

# Now make the aligment for BEAST. This adds sample time and deme to tip labels:
d3 = sarscov2::prep_tip_labels_phydyn(path_to_align = "data/algn.fas", path_to_save =  paste0("data/algn_prepped.fas"), 
                       regexprs = c( 'WF', 'WF') ) # 'WF' lets the function know that Weifang are the internal sequences


