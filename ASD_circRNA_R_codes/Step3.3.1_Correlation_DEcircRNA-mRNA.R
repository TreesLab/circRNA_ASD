if (!require(readxl)) install.packages('readxl')
if (!require(tidyverse)) install.packages('tidyverse')
if (!require(writexl)) install.packages('writexl')

library(tidyverse)
library(readxl)
library(writexl)

rm(list=ls(all=TRUE))
############################# input files #########################################

circRNA <-  read.table("input/circ1060_datRPM_73s.txt", header=TRUE, sep="\t")
circ60 = read.csv("input/circ60_indiv73.csv")

mRNA <-  read.table("input/73s_normalized_log2_FPKM_miRNA_targetG_new.transpose", header=TRUE, row.names=1)
CMM <- read_excel("output/circ_miRNA_mRNA_relation_short.xlsx", col_types = c("text"))

################################# DEcircRNA ##################################################
DEcirc_m <-  CMM %>% 
  filter(!is.na(DEcircRNA)) %>% 
  select(circRNAID, ENSG_ID) %>% 
  unique()

circ60 <- circ60 %>% as_tibble() %>% 
  rename(Sample.ID=Indiv) %>% 
  mutate(Sample.ID=str_replace_all(Sample.ID,"_","."))


mRNA <- mRNA %>% as_tibble() %>% 
  rename(Sample.ID=Indiv2)

DEcirc_m_spearman <- c()
DEcirc_m_n <- dim(DEcirc_m)[1]

for(i in 1:DEcirc_m_n){
  print(i)
  circ_m_One <- DEcirc_m[i,]
  
  circRNA_One <- circ60 %>% 
    select(Sample.ID, circ_m_One$circRNAID) %>% 
    rename(circRNAID=circ_m_One$circRNAID)
  
  check_mRNA=sum(1*(colnames(mRNA)==circ_m_One$ENSG_ID))
  if(check_mRNA==1){
    mRNA_One <- mRNA %>% 
      select(Sample.ID, circ_m_One$ENSG_ID) %>% 
      rename(mRNAID=circ_m_One$ENSG_ID)
    
    circRNA_mRNA_One <- circRNA_One %>% 
      left_join(mRNA_One, by="Sample.ID")
    
    cor_circ_m_rho <- cor.test(circRNA_mRNA_One$circRNAID, circRNA_mRNA_One$mRNAID, method="spearman")$estimate
    cor_circ_m_less_pvalue <- cor.test(circRNA_mRNA_One$circRNAID, circRNA_mRNA_One$mRNAID, method="spearman", alternative = "less")$p.value
    cor_circ_m_greater_pvalue <- cor.test(circRNA_mRNA_One$circRNAID, circRNA_mRNA_One$mRNAID, method="spearman", alternative = "greater")$p.value
    
    circ_m_One <- circ_m_One %>% 
      add_column(cor_circ_m_rho, cor_circ_m_less_pvalue, cor_circ_m_greater_pvalue)
    
    DEcirc_m_spearman <- rbind(DEcirc_m_spearman, circ_m_One)
  }
}  

#################################### module_circRNA ################################################################
#module_circ_m <- CMM %>% 
#  filter(is.na(DEcircRNA)) %>% 
#  select(circRNAID, ENSG_ID) %>% 
#  unique()
#
#circRNA <- circRNA %>% as_tibble()
#
#module_circ_m_spearman <- c()
#module_circ_m_n <- dim(module_circ_m)[1]
#
#for(i in 1:module_circ_m_n){
#  print(i)
#  circ_m_One <- module_circ_m[i,]
#  
#  circRNA_One <- circRNA %>% 
#    select(Sample.ID, circ_m_One$circRNAID) %>% 
#    rename(circRNAID=circ_m_One$circRNAID)
#  
#  check_mRNA=sum(1*(colnames(mRNA)==circ_m_One$ENSG_ID))
#  if(check_mRNA==1){
#    mRNA_One <- mRNA %>% 
#      select(Sample.ID, circ_m_One$ENSG_ID) %>% 
#      rename(mRNAID=circ_m_One$ENSG_ID)
#    
#    circRNA_mRNA_One <- circRNA_One %>% 
#      left_join(mRNA_One, by="Sample.ID")
#    
#    cor_circ_m_rho <- cor.test(circRNA_mRNA_One$circRNAID, circRNA_mRNA_One$mRNAID, method="spearman")$estimate
#    cor_circ_m_less_pvalue <- cor.test(circRNA_mRNA_One$circRNAID, circRNA_mRNA_One$mRNAID, method="spearman", alternative = "less")$p.value
#    cor_circ_m_greater_pvalue <- cor.test(circRNA_mRNA_One$circRNAID, circRNA_mRNA_One$mRNAID, method="spearman", alternative = "greater")$p.value
#    
#    circ_m_One <- circ_m_One %>% 
#      add_column(cor_circ_m_rho, cor_circ_m_less_pvalue, cor_circ_m_greater_pvalue)
#    
#    module_circ_m_spearman <- rbind(module_circ_m_spearman, circ_m_One)
#  }
#}  

############################################# output ###################################################################
write_xlsx(DEcirc_m_spearman,"output/DEcircRNA_mRNA_spearman.xlsx")

