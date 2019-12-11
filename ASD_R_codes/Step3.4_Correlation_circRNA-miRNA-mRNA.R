if (!require(readxl)) install.packages('readxl')
if (!require(tidyverse)) install.packages('tidyverse')
if (!require(writexl)) install.packages('writexl')

library(tidyverse)
library(readxl)
library(writexl)

rm(list=ls(all=TRUE))
############################# input files #########################################
CMi <- read_excel("output/circRNA_miRNA_spearman.xlsx")
MiM <- read_excel("output/miRNA_mRNA_spearman.xlsx")
DEcircM <- read.csv("output/DEcirc_mRNA_spearman.txt", sep=" ", header=FALSE)
ModulecircM <- read.csv("Output/Module_circ_mRNA_spearman.txt", sep=" ", header=FALSE)
CMM <- read_excel("output/circ_miRNA_mRNA_relation.xlsx", col_types = c("text"))
addMiM <- read.csv("input/58miRNA_targets_ENSG.txt", sep="", header=TRUE, colClasses = "character")
###################################################################################
CMM_short <- CMM %>% 
  select(circRNAID,miRNAID) %>%
  unique() %>% 
  left_join(addMiM, c("miRNAID"="ID")) %>% 
  unique()
  
DEcircM <- DEcircM %>% as_tibble()
DEcircM <- DEcircM %>% 
  mutate(cor_circ_m_less_pvalue=1-V4) %>% 
  rename(circRNAID=V1, ENSG_ID=V2, cor_circ_m_rho=V3, cor_circ_m_greater_pvalue=V4)

ModulecircM <- ModulecircM %>% as_tibble()
ModulecircM <- ModulecircM %>% 
  mutate(cor_circ_m_less_pvalue=1-V4) %>% 
  rename(circRNAID=V1, ENSG_ID=V2, cor_circ_m_rho=V3, cor_circ_m_greater_pvalue=V4)

addMiM <- addMiM %>% 
  as_tibble() %>% 
  mutate(ID=str_replace_all(ID, "\\.", "-")) %>% 
  select(ID, ENSG_ID) %>% 
  unique()



CM <- rbind(DEcircM, ModulecircM) %>% 
  unique()


CMM_spearman_short <- CMM_short %>% 
  left_join(CMi, c("circRNAID"="circRNAID", "miRNAID"="miRNAID")) %>% 
  left_join(MiM, c("miRNAID"="miRNAID", "ENSG_ID"="ENSG_ID")) %>% 
  left_join(CM, c("circRNAID"="circRNAID", "ENSG_ID"="ENSG_ID"))

CMM_spearman_short <- CMM_spearman_short %>% 
  filter(!is.na(cor_circ_mi_rho)) %>% 
  filter(!is.na(cor_mi_m_rho)) %>% 
  filter(!is.na(cor_circ_m_rho))


CMM_spearman_short1 <- CMM_spearman_short %>% 
  mutate(combinded_CMiless_MiMless_CMgreater_pvalue=pchisq(-2*(log(cor_circ_mi_less_pvalue)+log(cor_mi_m_less_pvalue)+log(cor_circ_m_greater_pvalue)), df=2*3, lower.tail=F))

CMM_short2 <- CMM %>% 
  select(circRNAID, Up_Down_circRNA, DEcircRNA, module_circRNA, miRNAID, DEmiRNA, module_DEmiRNA) %>% 
  unique()

CMM_spearman_short1 <-  CMM_spearman_short1 %>%
  left_join(CMM_short2,  c("circRNAID"="circRNAID", "miRNAID"="miRNAID")) %>% 
  select(circRNAID, "Up_Down_circRNA", DEcircRNA, module_circRNA, miRNAID, DEmiRNA, module_DEmiRNA, ENSG_ID, everything())
  
  
CMM_spearman_up_down <- CMM_spearman_short1 %>% 
  filter((Up_Down_circRNA=="up"& DEmiRNA=="down")) %>% 
  filter(cor_circ_mi_less_pvalue < 0.05)

CMM_spearman_up_down2 <- CMM_spearman_short1 %>% 
  filter(Up_Down_circRNA=="up") %>% 
  filter(str_detect(module_DEmiRNA, 'down_')) %>% 
  filter(cor_circ_mi_less_pvalue < 0.05)

CMM_spearman_down_up <- CMM_spearman_short1 %>% 
  filter((Up_Down_circRNA=="down"& DEmiRNA=="up")) %>% 
  filter(cor_circ_mi_less_pvalue < 0.05)

CMM_spearman_down_up2 <- CMM_spearman_short1 %>% 
  filter(Up_Down_circRNA=="down") %>%
  filter(str_detect(module_DEmiRNA, 'up_')) %>% 
  filter(cor_circ_mi_less_pvalue < 0.05)


CMM_spearman_CMi <- rbind(CMM_spearman_up_down, CMM_spearman_up_down2, CMM_spearman_down_up, CMM_spearman_down_up2) %>% unique()

CMM_spearman_CMiM <- CMM_spearman_CMi %>% 
  filter(cor_mi_m_less_pvalue < 0.05) %>% 
  filter(cor_circ_m_rho > 0) %>% 
  filter(combinded_CMiless_MiMless_CMgreater_pvalue < 0.05) %>% 
  unique()

############################# output files   ########################################
write_xlsx(CMM_spearman_short1,"output/circRNA_miRNA_mRNA_spearman.xlsx")
write_xlsx(CMM_spearman_CMiM,"output/sponge_circRNA_miRNA_mRNA_spearman.xlsx")

###############################################################################









  








