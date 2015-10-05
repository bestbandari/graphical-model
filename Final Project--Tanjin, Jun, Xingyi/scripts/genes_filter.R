
#load expression data file
fpkm.df <- read.table("tcga_fpkm_all_0.out",
                      sep=" ",
                      header=TRUE,
                      stringsAsFactors=FALSE)

data.cols <- 2:434
samnum <- 433

fpkmmatrix <- fpkm.df[,data.cols]
fpkmmu <- apply(fpkmmatrix, 1, function(fpkmvals) {mean(log2(fpkmvals[fpkmvals>0]))})
fpkmsd  <- apply(fpkmmatrix, 1, function(fpkmvals) {sd(log2(fpkmvals[fpkmvals>0]))})


#view sigma > 2 as statistical significant
mu_thres <- 2
sd_thres <- 2
z_thres <- 0.9

ginds <- c()
for (i in 1:nrow(fpkmmatrix))
{
  if (length(which(fpkmmatrix[i,] == 0)) < (z_thres * samnum))
  {
    ginds <- c(ginds,i)
  }
}

ginds_keep <- c()
for (i in 1:length(ginds))
{
  if (fpkmmu[ginds[i]] > mu_thres && fpkmsd[ginds[i]] > sd_thres)
  {
    ginds_keep <- c(ginds_keep, ginds[i])
  }
}

fpkmmx_new <- fpkm.df[ginds_keep,]
write.table(fpkmmx_new, file="tcga_fpkm_filtered.out", sep=" ", eol = "\n", row.names=FALSE, col.names=FALSE, quote=FALSE)

#normalization
fpkmmx_dat <- fpkmmx_new[,data.cols]
fpkmmx_nm <- apply(fpkmmx_dat, 1, function(fpkmval) {(fpkmval - min(fpkmval)) / (max(fpkmval)-min(fpkmval))})



