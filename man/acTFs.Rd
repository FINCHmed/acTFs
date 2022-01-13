\name{acTFs}
\alias{acTFs}
\title{activated Transcription Factors}
\usage{
GETacTFS(DEGup,DEGdown,totalgenenum,FDRcutoff)
}
\description{
To identify differentially activated TFs by examing the changing of their target genes.
}
\examples{
DEGup=c("EFCAB6","MAP2K6","GNPDA2")
DEGdown=c("LURAP1L","NPAP1","FGFR1")
result=GETacTFS(DEGup,DEGdown,totalgenenum=20250,FDRcutoff=0.05)
head(result$allTFs)
head(result$sigTFS)
head(result$sigTFsDEGnet)
}
