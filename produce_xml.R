invisible('
Produce xml for BEAST2 PhyDyn analysis
') 

# Requires:
# Skeleton for xml, which is available at emvolz-phylodynamics/sarscov2Rutils/sarscov2Rutils/inst/extdata/
# Prepped alignment with tiplabels including decimal date and deme
# Start tree (produced in eda1)
# Start date for epidemiological dynamics, here 2020.025
# Initial susceptible size, here 500



# Make the xmls 



format_xml0( xmlfn = "beast/seijr0.1.0_skeleton.xml", 
             fastafn = "data/algn_prepped.fas", 
             treefn = "data/startTrees.nwk", 
             start = 2020.025, susc_size = 500 ) 

# This will produce 8 xml files, each using one of the eight start trees produced in eda1.R
# It is important to note that the 8 xmls must be run in separate directories when running BEAST2, as they may overwrite the same .log files