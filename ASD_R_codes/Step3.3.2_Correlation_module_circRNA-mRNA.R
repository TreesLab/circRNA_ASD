if (!require(readxl)) install.packages('readxl')
if (!require(tidyverse)) install.packages('tidyverse')
if (!require(writexl)) install.packages('writexl')

library(tidyverse)
library(readxl)
library(writexl)

rm(list=ls(all=TRUE))
################################### input files #####################################
circRNA = read.table("input/circRNA1060_73s_RPM.txt", header=TRUE, sep="\t", row.names=1)
mRNA = read.table("input/73s_normalized_log2_FPKM_miRNA_targetG.transpose", header=TRUE, row.names=1)
mi.ci.modules = read.table("input/mi-ci_sig_INmodules_short.txt")
##########################################################################
circ.name = names(circRNA)
mRNA.name = names(mRNA)

circList = mi.ci.modules$V2
n.circ = length(circList)

n.mRNA = length(mRNA.name)

circ_mRNA_rho = c()
for(i in 1:n.circ)
{
  circ.one = circList[i]
  for(j in 2:n.mRNA)
  {
    mRNA.one = mRNA.name[j]
    rho.one = cor.test(circRNA[,circ.one], mRNA[,j], alternative = "greater", method="spearman")$estimate
    pvalue.one = cor.test(circRNA[,circ.one], mRNA[,j], alternative = "greater", method="spearman")$p.value
    out.one = c(as.character(circ.one), mRNA.one, rho.one, pvalue.one)
    circ_mRNA_rho = rbind(circ_mRNA_rho,out.one)
  }
}

############################### output files ############################################################
write.table(circ_mRNA_rho, "output/Module_circ_mRNA_spearman.txt", quote = FALSE, row.names = FALSE, col.names = FALSE)
