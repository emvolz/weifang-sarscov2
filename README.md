#  Code to reproduce analyses in "Genomic epidemiology of a densely sampled COVID19 outbreak in China"

Important files: 

* beast/seir.xml: Main results using PhyDyn package and SEIJR model
	- Sequence data can not be included in the xml but can be retrieved from GISAID
* R/eda1.R: Exploratory data analysis and outlier detection using `treedater`
* Other scripts in R/ will reproduce tables, figures, RTT


## Sequences: 

```
                Sequence ID      GISAID ID
1                 WFCDC0001 EPI_ISL_413691
2                 WFCDC0002 EPI_ISL_413692
3                 WFCDC0003 EPI_ISL_413693
4                 WFCDC0004 EPI_ISL_413694
5                 WFCDC0012 EPI_ISL_413697
6                 WFCDC0014 EPI_ISL_413711
7                 WFCDC0015 EPI_ISL_413729
8                 WFCDC0016 EPI_ISL_413746
9                 WFCDC0018 EPI_ISL_413748
10                WFCDC0019 EPI_ISL_413749
11                WFCDC0020 EPI_ISL_413750
12                WFCDC0021 EPI_ISL_413751
13                WFCDC0024 EPI_ISL_413753
14                WFCDC0026 EPI_ISL_413761
15                WFCDC0028 EPI_ISL_413791
16                WFCDC0029 EPI_ISL_413809
17                WFCDC0006 EPI_ISL_413695
18                WFCDC0009 EPI_ISL_413696
19                WFCDC0017 EPI_ISL_413747
20                WFCDC0023 EPI_ISL_413752
21     Australia/VIC01/2020 EPI_ISL_406844
22           Finland/1/2020 EPI_ISL_407079
23      Foshan/20SF207/2020 EPI_ISL_406534
24      Foshan/20SF210/2020 EPI_ISL_406535
25      France/IDF0373/2020 EPI_ISL_406597
26     Germany/BavPat1/2020 EPI_ISL_406862
27   Guangdong/20SF012/2020 EPI_ISL_403932
28   Guangdong/20SF014/2020 EPI_ISL_403934
29   Guangdong/20SF040/2020 EPI_ISL_403937
30   Guangdong/20SF201/2020 EPI_ISL_406538
31   Guangzhou/20SF206/2020 EPI_ISL_406533
32      Japan/AI/I-004/2020 EPI_ISL_407084
33       Nonthaburi/61/2020 EPI_ISL_403962
34       Nonthaburi/74/2020 EPI_ISL_403963
35   Shenzhen/SZTH-003/2020 EPI_ISL_406594
36         Singapore/1/2020 EPI_ISL_406973
37            Taiwan/2/2020 EPI_ISL_406031
38             USA-WA1/2020 EPI_ISL_404895
39             USA/AZ1/2020 EPI_ISL_406223
40             USA/CA1/2020 EPI_ISL_406034
41             USA/CA2/2020 EPI_ISL_406036
42             USA/IL1/2020 EPI_ISL_404253
43          Wuhan-Hu-1/2019 EPI_ISL_402125
44   Wuhan/HBCDC-HB-01/2019 EPI_ISL_402132
45 Wuhan/IPBCAMS-WH-01/2019 EPI_ISL_402123
46 Wuhan/IPBCAMS-WH-02/2019 EPI_ISL_403931
47 Wuhan/IPBCAMS-WH-03/2019 EPI_ISL_403930
48 Wuhan/IPBCAMS-WH-04/2019 EPI_ISL_403929
49    Wuhan/IVDC-HB-01/2019 EPI_ISL_402119
50    Wuhan/IVDC-HB-05/2019 EPI_ISL_402121
51          Wuhan/WH01/2019 EPI_ISL_406798
52          Wuhan/WH04/2020 EPI_ISL_406801
53    Wuhan/IVDC-HB-04/2020 EPI_ISL_402120

```
