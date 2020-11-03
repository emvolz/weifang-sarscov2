#  Code to reproduce analyses in "Genomic epidemiology of a densely sampled COVID19 outbreak in China"

Important files: 

* data/gisaid_db.fas: a sequence alignment downloaded from GISAID
* data/md.csv: metadata for sequence alignment
n.b. these cannot be provided in the GitHub package but are accessible from gisaid.org

* beast/seir.xml: Main results using PhyDyn package and SEIJR model
	- Sequence data can not be included in the xml but can be retrieved from GISAID
* R/eda1.R: Exploratory data analysis and outlier detection using `treedater`
* Other scripts in R/ will reproduce tables, figures, RTT

