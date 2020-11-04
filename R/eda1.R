invisible('
Exploratory data analysis with treedater 
for Weifang sequences
') 

library( ape ) 
require(sarscov2)
require(ggplot2)

d <- read.dna( 'data/algn_prepped.fas', format = 'fasta' )
raw <- dist.dna( d, model = 'raw' ) 
hky <- dist.dna( d, model = 'f84' )

.raw <- as.matrix( raw )
diag(.raw) <- NA 
print( mean( na.omit(as.vector(  .raw )) ) * 29855 )

# Make the starting trees (will also save a ML tree: "mltree_weifang.pdf")
# Here we have set the number of trees to 8
tds = sarscov2::make_starting_trees(fastafn = "data/algn_prepped.fas", treeoutfn = "data/startTrees.nwk", 
                          plotout = "mltree_weifang.pdf", ntres = 8, ncpu = 1)



td = tds[[1]]


# ROOT TO TIP!!

# this is code lifted from rootToTipRegressionPlot()
dT <- ape::node.depth.edgelength(td)
dG <- ape::node.depth.edgelength(td$intree)


# signif(td$timeOfMRCA, 12)


sts <- (td$timeOfMRCA + dT[1:ape::Ntip(td)])
nts <- (td$timeOfMRCA + dT)
mtip <- lm(dG[1:ape::Ntip(td)] ~ sts)
mall <- lm(dG ~ nts)

df <- data.frame(x = dT + td$timeOfMRCA, y = dG, col = c(rep("sample", 
                                                             ape::Ntip(td)), rep("internal", ape::Nnode(td))))



rtt <- ggplot2::ggplot(df, aes(x, y, col = col)) + geom_point() + theme_bw() + 
  geom_abline(slope = coef(mall)[2], intercept = coef(mall)[1], col = "black") +
  geom_abline(slope = coef(mtip)[2], intercept = coef(mtip)[1], col = "red") + 
  scale_color_manual(values = c("black", "red")) + 
  geom_hline(yintercept = 0, linetype = "dashed") +
  # geom_vline(xintercept = 2020, linetype = "dashed") +
  theme(legend.position = "", axis.title.y = element_text(size=20),
        axis.text.y = element_text(size=18),
        axis.text.x = element_text(size=18)) + 
  labs(x = "", y = "Evolutionary distance")+
  scale_y_continuous(breaks = c(0, 0.0001, 0.0002, 0.0003, 0.0004, 0.0005),
                     labels = scales::number_format(accuracy = 0.0001)) +
  scale_x_continuous(limits = Date2decimal(c("2019-12-01", "2020-05-01")), 
                     breaks = Date2decimal(c("2019-12-01", "2020-01-01", "2020-02-01", "2020-03-01", "2020-04-01", "2020-05-01")))


cat(' TMRCA ')
decimal2Date(-coef(mall)[1]/coef(mall)[2])

pdf('weifang-rtt-20.pdf')
rtt
dev.off()


# This will produce a time tree
quick_region_treeplot(td = tds[[1]], "WF")

