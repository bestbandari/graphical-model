#load expression data file
fpkm.df <- read.table("tcga_fpkm_all_0.out",
                      sep=" ",
                      header=TRUE,
                      stringsAsFactors=FALSE)

library(gdata)
library(extrafont)  # to get custom fonts
font.list <- fonts()

data.cols <- sample(2:434,10,replace=F)
ret.list <- apply(fpkm.df[,data.cols], 2, function(fpkmvals) {density(log2(fpkmvals), na.rm=TRUE)})

maxval <- max(fpkm.df[,data.cols], na.rm=TRUE)

colorinds <- c(24, 29, 31, 36, 41, 46, 119, 82, 125, 93)
#loadfonts()

# standard plot is 1.5" x 1.5"
pdf(file="fpkm_densities.pdf", 
    width=1.5, 
    height=1.5,
    family="Open Sans Light")

par(mai=c(0.45, 0.45, 0.04, 0.03),
    mgp=c(1.2, 0.2, 0),
    cex.lab=0.7,
    cex.axis=0.7,
    tcl=-0.2)

plot(c(-8,12),c(0,0.035), type="n", xlab=expression(paste(log[2],"(FPKM)")), ylab="density")
sapply(1:10, 
       function(i) {lines(ret.list[[i]],
                          lwd=0.5,
                          col=colors()[colorinds[i]])})
legend(x=5,
       y=0.035,
       data.cols[1:10],
       col=colors()[colorinds],
       lty=rep(1,10),
       lwd=rep(2,10),
       seg.len=0.5,
       y.intersp=0.7,
       x.intersp=0.2,
       cex=0.6,
       bty="n"
       )

dev.off()

pdf(file="fpkm_means-sd.pdf",
    #width=10,height=10,
    family="Open Sans Light")

data.cols <- 2:434
fpkmmatrix <- fpkm.df[,data.cols]
fpkmmean <- apply(fpkmmatrix, 1, function(fpkmvals) {mean(log2(fpkmvals[fpkmvals>0]))})
fpkmvar  <- apply(fpkmmatrix, 1, function(fpkmvals) {sd(log2(fpkmvals[fpkmvals>0]))})

plot(fpkmmean,fpkmvar,pch='.',col='blue',xlab=expression(paste(mu)),ylab=expression(paste(sigma)));

dev.off()

