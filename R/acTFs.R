# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

GETacTFS <- function(DEGup,DEGdown,totalgenenum,pcutoff) {
  outab<-NULL
  for (i in TFlist) {
    # Activation <- load("Activation.RData")
    # Repression <- load("Repression.RData")
    # TFlist <- load("TFlist.RData")
    TARGETAC<-Activation[Activation$TF==i,]
    targetAC<-TARGETAC$TARGET
    TARGETRE<-Repression[Repression$TF==i,]
    targetRE<-TARGETRE$TARGET
    a=length(intersect(targetAC,DEGup[,1]))+length(intersect(targetRE,DEGdown[,1]))
    b=length(DEGup[,1])+length(DEGdown[,1])-a
    c=length(targetAC)+length(targetRE)-a
    d=totalgenenum-length(DEGup[,1])-length(DEGdown[,1])-c
    fish<-fisher.test(matrix(c(a,c,b,d),nrow=2))
    p<-fish$p.value
    outab1<-cbind(i,p)
    outab<-rbind(outab,outab1)

  }
  allTFs<-data.frame(outab)
  sigTFS<-allTFs[allTFs$p<pcutoff,]
  tfs<-sigTFS$i
  out1<-NULL
  out2<-NULL
  out3<-NULL
  out4<-NULL
  for (j in tfs) {
    TARGETAC<-Activation[Activation$TF==j,]
    targetAC<-  TARGETAC$TARGET
    TARGETRE<-Repression[Repression$TF==j,]
    targetRE<-  TARGETRE$TARGET
    ac <- intersect(targetAC,DEGup[,1])
    re <- intersect(targetRE,DEGdown[,1])
    deg<-union(ac, re)
    for (gene in ac) {
      out0<-cbind(j,gene,"ACTIVATION")
      out1<-rbind(out1,out0)
    }

    for (gene in re) {
      out2<-cbind(j,gene,"REPRESSION")
      out3<-rbind(out3,out2)
    }
    out4<-rbind(out1,out3)
  }
  sigTFsDEGnet<-out4
  myresult<-list(allTFs=allTFs,sigTFS=sigTFS,sigTFsDEGnet=sigTFsDEGnet)
  return(myresult)
}

# hello(allgenes,DEGup,DEGdown)
# dir()
# allgenes<-read.table("all.txt",sep="\t",header=T,check.names=F)
# DEGup<-read.table("up.txt",sep="\t",header=T,check.names=F)
# DEGdown<-read.table("down.txt",sep="\t",header=T,check.names=F)
# library(test)
# DEGup="A"
# DEGdown="B"
# hello()
# rm(list = ls())
# library(test)
# hello("ZNRD1")
# load("Activation.RData")
# library(devtools)
# use_data(Activation,Repression,TFlist,internal = TRUE,overwrite = TRUE)
# dir()
# system.file("extdata","2012.csv",package="testdata")
# qq=GETacTFS (DEGup,DEGdown,22000,0.05)
# str(qq)
# qq[1:4,1:2]
#
# mode(qqq)
# qqq=data.frame(qq)
# qqq$
#qq$sigTFS
# str(qq)
# qq$FDR
#[allTFs$p<pcutoff]
# head(qq$allTFs)
# asdf=qq$allTFs
# asdf$p
# mode(qq$FDR)
# qwert=rbind(qq$allTFs,qq$FDR)
# head(qq$sigTFsDEGnet)
