### To install:

```
# install devtools if necessary
install.packages('devtools')

# install the acTFs package
devtools::install_github("liguangqimed/acTFs")

# load
library(acTFs)
```
### Tutorial
##### The package is designed to identify significantly activated transcription factors (TFs) in the interested samples compared to the control group. Instead of comparing the expression of the TFs themselves, the significance of a TF activation was measured by Fisher’s exact test on its target genes. For a TF, both the upregulation of its activated genes and the downregulation of its repressed genes are considered as the enhancement of its function. First, users should perform DEG analysis (DEseq2 is recommended) between two groups of samples, then provide the total number of genes in the analysis and the name of the DEGs. The package includes a total of 3144 TF-target activation relationships and 1922 TF-target repression relationships derived from published articles for reference (TRRUST). The "GETacTFS" function would exam the target genes changing of all 795 known TFs  considering the regulation mode. The result includes the pvalue of each TF and a network of the significantly activated TFs and their targeted DEGs.
####  @param DEGup A vector of the up-regulated DEG names(official symbol)
##### @param DEGdown A vector of the down-regulated DEG names(official symbol)
##### @param totalgenenum The total gene numbers used in DEG analysis
##### @param FDRcutoff The cutoff of FDR to define activated TFs
##### @return allTFs: all the TFs and pvalues
##### @return sigTFS: significanly activated TFs and pvalues
##### @return sigTFsDEGnet: relations between the significanly activated TFs and their target DEGs (activation or repression).This list can be used for Cytoscape visualization
### examples
##### input from txt (only need gene symbol names in one column)
```
DEGup=read.table("up.txt",sep="\t",header=T,check.names=F)
DEGup=DEGup[,1]
DEGdown=read.table("down.txt",sep="\t",header=T,check.names=F)
DEGdown=DEGdown[,1]
result=GETacTFS(DEGup,DEGdown,totalgenenum=20250,FDRcutoff=0.05)
head(result$allTFs)
head(result$sigTFS)
head(result$sigTFsDEGnet)
```
##### Cite:
##### https://github.com/liguangqimed/acTFs
