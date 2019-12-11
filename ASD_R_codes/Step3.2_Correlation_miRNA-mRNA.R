if (!require(readxl)) install.packages('readxl')
if (!require(tidyverse)) install.packages('tidyverse')
if (!require(writexl)) install.packages('writexl')

library(tidyverse)
library(readxl)
library(writexl)

rm(list=ls(all=TRUE))
############################# input files #########################################
miRNA = read.csv("input/miRNA58_indiv73.csv")
mRNA = read.table("input/73s_normalized_log2_FPKM_miRNA_targetG.transpose", header=TRUE, row.names=1)
addMiM <- read.csv("input/58miRNA_targets_ENSG.txt", sep="", header=TRUE,  colClasses = "character")
############################ reform data format ######################################################
miRNA <- miRNA %>% 
         as_tibble() %>% 
         mutate(FC=as.character(FC)) %>% 
         mutate(FC=str_replace_all(FC, "_", ".")) %>% 
         rename(Sample.ID=FC)

names(miRNA) <- str_replace_all(names(miRNA), "\\.", "-")
miRNA <- miRNA %>% 
  rename(Sample.ID=`Sample-ID`)

mRNA <- mRNA %>% 
        as_tibble() %>% 
        rename(Sample.ID=Indiv2)

mi_m <- addMiM %>% 
  as_tibble() %>% 
  mutate(ID=str_replace_all(ID, "\\.", "-")) %>% 
  select(ID, ENSG_ID) %>% 
  rename(miRNAID=ID) %>% 
  unique()

mi_m_spearman <- c()
mi_m_n <- dim(mi_m)[1]

for(i in 1:mi_m_n){
  print(i)
  mi_m_One <- mi_m[i,]
  
  miRNA_One <- miRNA %>% 
    select(Sample.ID, mi_m_One$miRNAID) %>% 
    rename(miRNAID=mi_m_One$miRNAID)
  
  
  check_mRNA=sum(1*(colnames(mRNA)==mi_m_One$ENSG_ID))
  
  if(check_mRNA==1){
    mRNA_One <- mRNA %>% 
      select(Sample.ID, mi_m_One$ENSG_ID) %>% 
      rename(mRNAID=mi_m_One$ENSG_ID)
  
    miRNA_mRNA_One <- miRNA_One %>% 
      left_join(mRNA_One, by="Sample.ID")
  
    cor_mi_m_rho <- cor.test(miRNA_mRNA_One$miRNAID, miRNA_mRNA_One$mRNAID, method="spearman")$estimate
    cor_mi_m_less_pvalue <- cor.test(miRNA_mRNA_One$miRNAID, miRNA_mRNA_One$mRNAID, method="spearman", alternative = "less")$p.value
    cor_mi_m_greater_pvalue <- cor.test(miRNA_mRNA_One$miRNAID, miRNA_mRNA_One$mRNAID, method="spearman", alternative = "greater")$p.value
    mi_m_One <- mi_m_One %>% 
      add_column(cor_mi_m_rho, cor_mi_m_less_pvalue, cor_mi_m_greater_pvalue)
  
    mi_m_spearman <- rbind(mi_m_spearman, mi_m_One)
   }
}  

miRNA_mRNA_spearman <-  mi_m_spearman %>% 
  unique()

############################################################################################################################
write_xlsx(mi_m_spearman,"output/miRNA_mRNA_spearman.xlsx")


