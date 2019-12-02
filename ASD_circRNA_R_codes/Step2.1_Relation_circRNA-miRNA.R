if (!require(readxl)) install.packages('readxl')
if (!require(tidyverse)) install.packages('tidyverse')
if (!require(writexl)) install.packages('writexl')

library(readxl)
library(tidyverse)
library(writexl)

rm(list=ls(all=TRUE))
################################  input files #########################################################

## miRNAs targeted by  DEcircRNAs
circMiR = read_excel("input/RNA22_circRNA_miRNA_module.xlsx", sheet="60circ_58mi")
## DEcircRNAs
circDE = read_excel("input/RNA22_circRNA_miRNA_module.xlsx", sheet="60circ_DE")

## miRNAs targeted by module circRNA
module_circMiR = read_excel("input/RNA22_circRNA_miRNA_module.xlsx", sheet="circ_mi_Modules")
## module circRNA
module_circDE = read_excel("input/RNA22_circRNA_miRNA_module.xlsx", sheet="circModules_DE")

#######################################################################################################

circMiR.bs <- circMiR %>% 
  select(-DEmiRNA)

circMiR.DEmiRNA <- circMiR %>% 
  select(miRNAID, DEmiRNA)
  
circMiR.list <- gather(circMiR.bs, key = "circRNAID", value = "targetNum", -miRNAID) %>% 
  filter(targetNum >0)

circMiR.list <- circMiR.list %>% 
     left_join(circMiR.DEmiRNA, by="miRNAID") %>% 
      left_join(circDE, by="circRNAID") %>% 
      mutate(Up_Down_circRNA=DEcircRNA)


module_circMiR.bs <- module_circMiR %>% 
  select(-DEmiRNA)
module_circMiR.DEmiRNA <- module_circMiR %>% 
  select(miRNAID, DEmiRNA)

module_circMiR.list <- gather(module_circMiR.bs, key = "circRNAID", value = "targetNum", -miRNAID) %>% 
  filter(targetNum > 0)

module_circDE <- module_circDE %>%
  mutate(Up_Down_circRNA=DEmodule) %>% 
  unite(module_circRNA, DEmodule, module, sep="_")

module_circMiR.list <- module_circMiR.list %>% 
  left_join(module_circMiR.DEmiRNA, by="miRNAID") %>% 
  left_join(module_circDE, by="circRNAID")

circMiR.list.short <- circMiR.list %>% 
  select(circRNAID, miRNAID, targetNum, Up_Down_circRNA, DEmiRNA)

circMiR.list.short2 <- circMiR.list %>% 
  select(circRNAID, DEcircRNA) %>% 
  unique()

module_circMiR.list.short <- module_circMiR.list %>% 
  select(circRNAID, miRNAID, targetNum, Up_Down_circRNA, DEmiRNA)

module_circMiR.list.short2 <- module_circMiR.list %>% 
  select(circRNAID, module_circRNA) %>% 
  unique()

circMi_relation <- 
  rbind(circMiR.list.short, module_circMiR.list.short) %>% 
  unique() %>% 
  left_join(circMiR.list.short2, by=c("circRNAID"="circRNAID")) %>% 
  left_join(module_circMiR.list.short2, by=c("circRNAID"="circRNAID")) %>% 
  mutate(miRNAID=str_replace_all(miRNAID, "_", "-")) %>% 
  select(circRNAID, Up_Down_circRNA, DEcircRNA, module_circRNA, miRNAID, DEmiRNA, targetNum) %>% 
  rename(CircMi_targetNum=targetNum)

###################################  output  ######################################################
write_xlsx(circMi_relation, "output/circRNA_miRNA_relation.xlsx")













