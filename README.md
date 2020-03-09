# 

Code to reproduce analyses in `Genomic epidemiology of a densely sampled COVID19 outbreak in China`

Important files: 

* beast/seir.xml: Main results using PhyDyn package and SEIJR model
	- Sequence data can not be included in the xml but can be retrieved from GISAID
* R/eda1.R: Exploratory data analysis and outlier detection using `treedater`
* Other scripts in R/ will reproduce tables, figures, RTT


## Sequences: 

```
1                    Australia/VIC01/2020
2                          Finland/1/2020
3                     Foshan/20SF207/2020
4                     Foshan/20SF210/2020
5                     France/IDF0373/2020
6                    Germany/BavPat1/2020
7                  Guangdong/20SF012/2020
8                  Guangdong/20SF014/2020
9                  Guangdong/20SF040/2020
10                 Guangdong/20SF201/2020
11                 Guangzhou/20SF206/2020
12                    Japan/AI/I-004/2020
13                     Nonthaburi/61/2020
14                     Nonthaburi/74/2020
15                 Shenzhen/SZTH-003/2020
16                       Singapore/1/2020
17                          Taiwan/2/2020
18                           USA-WA1/2020
19                           USA/AZ1/2020
20                           USA/CA1/2020
21                           USA/CA2/2020
22                           USA/IL1/2020
23                              WFCDC0001
24                              WFCDC0002
25                              WFCDC0003
26                              WFCDC0004
27                              WFCDC0006
28                              WFCDC0009
29                              WFCDC0012
30                              WFCDC0014
31                              WFCDC0015
32                              WFCDC0016
33                              WFCDC0017
34                              WFCDC0018
35                              WFCDC0019
36                              WFCDC0020
37                              WFCDC0021
38                              WFCDC0023
39                              WFCDC0024
40                              WFCDC0026
41                              WFCDC0028
42                              WFCDC0029
43                        Wuhan-Hu-1/2019
44                 Wuhan/HBCDC-HB-01/2019
45               Wuhan/IPBCAMS-WH-01/2019
46               Wuhan/IPBCAMS-WH-02/2019
47               Wuhan/IPBCAMS-WH-03/2019
48               Wuhan/IPBCAMS-WH-04/2019
49                  Wuhan/IVDC-HB-01/2019
50                  Wuhan/IVDC-HB-05/2019
51                        Wuhan/WH01/2019
52                        Wuhan/WH04/2020
53                  Wuhan/IVDC-HB-04/2020

```
