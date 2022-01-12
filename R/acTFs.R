#' activated Transcription Factors
#' @author liguangqimed
#' @param DEGup The up-regulated DEG names(official symbol) provided as a list
#' @param DEGdown The down-regulated DEG names(official symbol) provided as a list
#' @param totalgenenum The total gene numbers used in DEG analysis
#' @param pcutoff the cutoff of pvalue to define activated TFs
#'
#' @return allTFs: all the TFs and pvalues
#' @return sigTFS: significanly activated TFs and pvalues
#' @return sigTFsDEGnet: relations between the significanly activated TFs and their target DEGs (activation or repression).This relation list can be used for Cytoscape for visualization
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

