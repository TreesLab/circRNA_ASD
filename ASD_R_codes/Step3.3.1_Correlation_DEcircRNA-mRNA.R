if (!require(readxl)) install.packages('readxl')
if (!require(tidyverse)) install.packages('tidyverse')
if (!require(writexl)) install.packages('writexl')

library(tidyverse)
library(readxl)
library(writexl)

rm(list=ls(all=TRUE))
#################################### input files  ################################################################
circ60 = read.table("circ60_indiv73.txt" ,header=T, row.names=1)
mRNA = read.table("73s_normalized_log2_FPKM_miRNA_targetG.transpose", header=TRUE, row.names=1)
##################################################################################################################
circ.name = names(circ60)
mRNA.name = names(mRNA)

n.circ = length(circ.name)
n.mRNA = length(mRNA.name)

circ_mRNA_rho = c()
for(i in 2:n.circ)
{
  circ.one = circ.name[i]
  for(j in 2:n.mRNA)
  {
    mRNA.one = mRNA.name[j]
    rho.one = cor.test(circ60[,i], mRNA[,j], alternative = "greater", method="spearman")$estimate
    pvalue.one = cor.test(circ60[,i], mRNA[,j], alternative = "greater", method="spearman")$p.value
    out.one = c(circ.one, mRNA.one, rho.one, pvalue.one)
    circ_mRNA_rho = rbind(circ_mRNA_rho,out.one)
    
  }
}
#################################### output files ################################################################
write.table(circ_mRNA_rho, "output/DEcirc_mRNA_spearman.txt", quote = FALSE, row.names = FALSE, col.names = FALSE)

