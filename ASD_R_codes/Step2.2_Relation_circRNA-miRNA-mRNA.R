if (!require(readxl)) install.packages('readxl')
if (!require(tidyverse)) install.packages('tidyverse')
if (!require(writexl)) install.packages('writexl')

library(readxl)
library(tidyverse)
library(writexl)

rm(list=ls(all=TRUE))
######################################## input files ########################################################################

circ_mi <- read_excel("output/circRNA_miRNA_relation.xlsx")
mi_m_known = read_excel("input/Supplemental_Table S4_targets_of_58miRNAs_new.xlsx", sheet="37miRNAs vs targets")
mi_m_novel = read_excel("input/Supplemental_Table S4_targets_of_58miRNAs_new.xlsx", sheet="21novel_miRNAs vs targets")

#############################################################################################################################

circ_mi_m_known <- circ_mi %>% 
  left_join(mi_m_known, by=c("miRNAID"="miRNA_ID")) %>% 
  add_column(miRNA_type="known") %>% 
  add_column(miRDB_TargetScore=NA)


circ_mi_m_novel <- circ_mi %>%
  left_join(mi_m_novel, by=c("miRNAID"="miRNA_ID")) %>% 
  add_column(miRNA_type="novel") %>% 
  add_column(`TargetScan (with IPA filter score < -0.16) (1: yes)`=NA, 
             `Ingenuity_Expert_Finding_in_IPA (1: yes)`=NA, 
             `Confidence (from IPA)`=NA, 
             `TarBase_v8 (1: yes)`=NA,
             `starBase_v2 (1: yes)`=NA,
             `AgoExpNum (from starBase_v2)`=NA,
             `experimentally supported (C or E or F)`=NA)

circ_mi_m_relation <- rbind(circ_mi_m_known, circ_mi_m_novel) %>% 
  select(circRNAID, Up_Down_circRNA,DEcircRNA, module_circRNA, miRNAID, DEmiRNA, CircMi_targetNum,
         miRNA_type, Gene_Symbol, ENSG_ID, everything()) %>% 
  filter(Gene_Symbol!="NA") 



circ_mi_m_relation_short <- circ_mi_m_relation %>%
  select(circRNAID, Up_Down_circRNA, DEcircRNA, module_circRNA, miRNAID, ENSG_ID) %>% 
  unique() 
  

####################################  output  ######################################  
write_xlsx(circ_mi_m_relation,"output/circ_miRNA_mRNA_relation.xlsx")
write_xlsx(circ_mi_m_relation_short,"output/circ_miRNA_mRNA_relation_short.xlsx")






