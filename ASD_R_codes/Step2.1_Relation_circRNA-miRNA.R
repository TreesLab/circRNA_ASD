if (!require(readxl)) install.packages('readxl')
if (!require(tidyverse)) install.packages('tidyverse')
if (!require(writexl)) install.packages('writexl')

library(readxl)
library(tidyverse)
library(writexl)

rm(list=ls(all=TRUE))
################################  input files #########################################################

## DEcircRNAs
circMiR = read_excel("input/RNA22_circRNA_miRNA_module.xlsx", sheet="60circ_58mi")
circDE = read_excel("input/RNA22_circRNA_miRNA_module.xlsx", sheet="60circ_DE")

## module circRNA
module_circMiR = read_excel("input/RNA22_circRNA_miRNA_module.xlsx", sheet="circ_mi_Modules")
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
  select(-module_DEmiRNA)
module_circMiR.DEmiRNA <- module_circMiR %>% 
  select(miRNAID, module_DEmiRNA)

module_circMiR.list <- gather(module_circMiR.bs, key = "circRNAID", value = "targetNum", -miRNAID) %>% 
  filter(targetNum > 0)

module_circDE <- module_circDE %>%
  mutate(Up_Down_circRNA=DEmodule) %>% 
  unite(module_circRNA, DEmodule, module, sep="_")

module_circMiR.list <- module_circMiR.list %>% 
  left_join(module_circMiR.DEmiRNA, by="miRNAID") %>% 
  left_join(module_circDE, by="circRNAID")

circMiR.list.short <- circMiR.list %>% 
  select(circRNAID, miRNAID, targetNum, Up_Down_circRNA)

circMiR.list.short2 <- circMiR.list %>% 
  select(circRNAID, DEcircRNA) %>% 
  unique()

circMiR.list.short3 <- circMiR.list %>% 
  select(miRNAID, DEmiRNA) %>% 
  unique()


module_circMiR.list.short <- module_circMiR.list %>% 
  select(circRNAID, miRNAID, targetNum, Up_Down_circRNA)

module_circMiR.list.short2 <- module_circMiR.list %>% 
  select(circRNAID, module_circRNA) %>% 
  unique()

module_circMiR.list.short3 <- module_circMiR.list %>% 
  select(miRNAID, module_DEmiRNA) %>% 
  unique()

circMi_relation <- 
  rbind(circMiR.list.short, module_circMiR.list.short) %>% 
  unique() %>% 
  left_join(circMiR.list.short2, by=c("circRNAID"="circRNAID")) %>% 
  left_join(module_circMiR.list.short2, by=c("circRNAID"="circRNAID")) %>% 
  left_join(circMiR.list.short3, by=c("miRNAID"="miRNAID")) %>% 
  left_join(module_circMiR.list.short3, by=c("miRNAID"="miRNAID")) %>%
  mutate(miRNAID=str_replace_all(miRNAID, "_", "-")) %>% 
  select(circRNAID, Up_Down_circRNA, DEcircRNA, module_circRNA, miRNAID, DEmiRNA, module_DEmiRNA, targetNum) %>% 
  rename(CircMi_targetNum=targetNum) 
  

###########################################################################################################################
write_xlsx(circMi_relation, "output/circRNA_miRNA_relation.xlsx")













