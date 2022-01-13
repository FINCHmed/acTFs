#' activated Transcription Factors
#' The package is designed to identify significantly activated transcription factors (TFs) in the interested samples compared to the control group. Instead of comparing the expression of the TFs themselves, the significance of a TF activation was measured by Fisher’s exact test on its target genes. For a TF, both the upregulation of its activated genes and the downregulation of its repressed genes are considered as the enhancement of its function. First, users should perform DEG analysis (DEseq2 is recommended) between two groups of samples, then provide the total number of genes in the analysis and the name of the DEGs. The package includes a total of 3144 TF-target activation relationships and 1922 TF-target repression relationships derived from published articles for reference (TRRUST). The "GETacTFS" function would exam the target genes changing of all 795 known TFs considering the regulation mode. The result includes the pvalue of each TF and a network of the significantly activated TFs and their targeted DEGs.
#' @author liguangqimed
#' @param DEGup A vector of the up-regulated DEG names(official symbol)
#' @param DEGdown A vector of the down-regulated DEG names(official symbol)
#' @param totalgenenum The total gene numbers used in DEG analysis
#' @param pcutoff The cutoff of pvalue to define activated TFs
#'
#' @return allTFs: all the TFs and pvalues
#' @return sigTFS: significanly activated TFs and pvalues
#' @return sigTFsDEGnet: relations between the significanly activated TFs and their target DEGs (activation or repression).This list can be used for Cytoscape visualization
#' @export
#'
#' @examples
#' DEGup=c("EFCAB6","MAP2K6","GNPDA2")
#' DEGdown=c("LURAP1L","NPAP1","FGFR1")
#' result=GETacTFS(DEGup,DEGdown,totalgenenum=20000,pcutoff=0.05)
#' head(result$allTFs)
#' head(result$sigTFS)
#' head(result$sigTFsDEGnet)
#'
#' DEGup=read.table("up.txt",sep="\t",header=T,check.names=F)
#' DEGup=DEGup[,1]
#' DEGdown=read.table("down.txt",sep="\t",header=T,check.names=F)
#' DEGdown=DEGdown[,1]
#' result=GETacTFS(DEGup,DEGdown,totalgenenum=20000,pcutoff=0.05)
#' head(result$allTFs)
#' head(result$sigTFS)
#' head(result$sigTFsDEGnet)
GETacTFS <- function(DEGup,DEGdown,totalgenenum,pcutoff) {
  outab<-NULL
  for (i in TFlist) {
    TARGETAC<-Activation[Activation$TF==i,]
    targetAC<-TARGETAC$TARGET
    TARGETRE<-Repression[Repression$TF==i,]
    targetRE<-TARGETRE$TARGET
    a=length(intersect(targetAC,DEGup))+length(intersect(targetRE,DEGdown))
    b=length(DEGup)+length(DEGdown)-a
    c=length(targetAC)+length(targetRE)-a
    d=totalgenenum-length(DEGup)-length(DEGdown)-c
    fish<-fisher.test(matrix(c(a,c,b,d),nrow=2))
    p<-fish$p.value
    outab1<-cbind(i,p)
    outab<-rbind(outab,outab1)

  }
  allTFs<-data.frame(outab)
  colnames(allTFs)=c("TF","p")
  sigTFS<-allTFs[allTFs$p<pcutoff,]
  tfs<-sigTFS$TF
  out1<-NULL
  out2<-NULL
  out3<-NULL
  out4<-NULL
  for (j in tfs) {
    TARGETAC<-Activation[Activation$TF==j,]
    targetAC<-  TARGETAC$TARGET
    TARGETRE<-Repression[Repression$TF==j,]
    targetRE<-  TARGETRE$TARGET
    ac <- intersect(targetAC,DEGup)
    re <- intersect(targetRE,DEGdown)
    deg<-union(ac, re)
    for (gene in ac) {
      out0<-cbind(j,gene,"ACTIVATION")
      out1<-rbind(out1,out0)
      colnames(out1)=c("TF","Target","mode")
    }

    for (gene in re) {
      out2<-cbind(j,gene,"REPRESSION")
      out3<-rbind(out3,out2)
      colnames(out3)=c("TF","Target","mode")
    }
    out4<-rbind(out1,out3)
  }
  sigTFsDEGnet<-out4
  myresult<-list(allTFs=allTFs,sigTFS=sigTFS,sigTFsDEGnet=sigTFsDEGnet)
  return(myresult)
}

