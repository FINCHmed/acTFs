### To install:
#### install.packages("devtools")
#### devtools::install_github("liguangqimed/acTFs")
### Aim
#### Due to the central role of TFs in tumour biology, we would like to identify significantly activated TFs in the interested samples compared to the control group. Instead of comparing the expression of the TFs themselves, the significance of a TF activation was measured by Fisher’s exact test on its target genes. A total of 3144 TF-target activation relationships and 1922 TF-target repression relationships derived from published articles were downloaded from TRRUST (53)




### examples
```
DEGup=c("EFCAB6","MAP2K6","GNPDA2")
DEGdown=c("LURAP1L","NPAP1","FGFR1")
result=GETacTFS(DEGup,DEGdown,totalgenenum=20000,pcutoff=0.05)
head(result$allTFs)
head(result$sigTFS)
head(result$sigTFsDEGnet)
```
### input from txt (only need gene symbol names in one column)
```
DEGup=read.table("up.txt",sep="\t",header=T,check.names=F)
DEGup=DEGup[,1]
DEGdown=read.table("down.txt",sep="\t",header=T,check.names=F)
DEGdown=DEGdown[,1]
result=GETacTFS(DEGup,DEGdown,totalgenenum=20000,pcutoff=0.05)
head(result$allTFs)
head(result$sigTFS)
head(result$sigTFsDEGnet)
```

