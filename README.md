#  Code to reproduce analyses in "Genomic epidemiology of a densely sampled COVID19 outbreak in China"

Important files: 

* data/gisaid_db.fas: a sequence alignment downloaded from GISAID
* data/md.csv: metadata for sequence alignment
n.b. these cannot be provided in the GitHub package but are accessible from gisaid.org

* beast/seijr0.1.0_skeleton.xml: Main results using PhyDyn package and SEIJR model

Pipeline:
* R/sampling_reference_set.R
* R/eda1.R: Exploratory data analysis and outlier detection using `treedater`, producing ML and time trees, RTT regression
* R/produce_xml.R
* Run PhyDyn on BEAST2 using xmls
* R/process_BEAST_output.R
* R/produce_epidemic_plots.R
* R/produce_trees.R