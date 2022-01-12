\name{acTFs}
\alias{acTFs}
\title{activated Transcription Factors}
\usage{
GETacTFS(DEGup,DEGdown,totalgenenum,pcutoff)
}
\description{
To identify differentially activated TFs by examing the changing of their target genes.
    DEGdown: The down-regulated DEG names(official symbol) provided as an list.
    DEGup: The up-regulated DEG names(official symbol) provided as an list.
    totalgenenum: the gene names where DEGs were
    pcutoff:
}
\examples{
allgenes<-read.table("allgenes.txt",sep="\t",header=T,check.names=F)
DEGup<-read.table("DEGup.txt",sep="\t",header=T,check.names=F)
DEGdown<-read.table("DEGdown.txt",sep="\t",header=T,check.names=F)
result<-GETacTFS(allgenes,DEGup,DEGdown,0.05)
}
