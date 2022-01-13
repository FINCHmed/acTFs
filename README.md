### To install:
#### install.packages("devtools")
#### devtools::install_github("liguangqimed/acTFs")
### examples
#####  DEGup=c("EFCAB6","MAP2K6","GNPDA2")
#####  DEGdown=c("LURAP1L","NPAP1","FGFR1")
#####  result=GETacTFS(DEGup,DEGdown,totalgenenum=20000,pcutoff=0.05)
#####  head(result$allTFs)
#####  head(result$sigTFS)
#####  head(result$sigTFsDEGnet)
#####  DEGup=read.table("up.txt",sep="\t",header=T,check.names=F)
#####  DEGup=DEGup[,1]
#####  DEGdown=read.table("down.txt",sep="\t",header=T,check.names=F)
#####  DEGdown=DEGdown[,1]
#####  result=GETacTFS(DEGup,DEGdown,totalgenenum=20000,pcutoff=0.05)
#####  head(result$allTFs)
#####  head(result$sigTFS)
#####  head(result$sigTFsDEGnet)
`DEGup=c("EFCAB6","MAP2K6","GNPDA2")
DEGdown=c("LURAP1L","NPAP1","FGFR1")
 result=GETacTFS(DEGup,DEGdown,totalgenenum=20000,pcutoff=0.05)
head(result$allTFs)
head(result$sigTFS)
head(result$sigTFsDEGnet)
DEGup=read.table("up.txt",sep="\t",header=T,check.names=F)
 DEGup=DEGup[,1]
DEGdown=read.table("down.txt",sep="\t",header=T,check.names=F)
 DEGdown=DEGdown[,1]
result=GETacTFS(DEGup,DEGdown,totalgenenum=20000,pcutoff=0.05)
 head(result$allTFs)
 head(result$sigTFS)
 head(result$sigTFsDEGnet)`
