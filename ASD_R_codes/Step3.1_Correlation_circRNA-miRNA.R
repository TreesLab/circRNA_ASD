if (!require(readxl)) install.packages('readxl')
if (!require(tidyverse)) install.packages('tidyverse')
if (!require(writexl)) install.packages('writexl')

library(tidyverse)
library(readxl)
library(writexl)

rm(list=ls(all=TRUE))
############################# input files #########################################

circRNA = read.table("input/circ1060_datRPM_73s.txt", header=TRUE, sep="\t")
circ60 = read.csv("input/circ60_indiv73.csv")

miRNA = read.table("input/miRNA699_73s_exp.txt", header=TRUE, sep="\t")
miRNA58 = read.csv("input/miRNA58_indiv73.csv")

CMM <- read_excel("output/circ_miRNA_mRNA_relation_short.xlsx", col_types = c("text"))

########################## reform data format #########################################################

circRNA <- circRNA %>% as_tibble()
circ60 <- circ60 %>% as_tibble()

circ60 <- circ60 %>% 
  mutate(Indiv=as.character(Indiv)) %>% 
  mutate(Indiv=str_replace_all(Indiv,"_", ".")) %>% 
  rename(Sample.ID=Indiv)


miRNA <- miRNA %>% as_tibble()
names(miRNA) <- str_replace_all(names(miRNA), "_", "-")


miRNA58 <- miRNA58 %>% as_tibble()
miRNA58 <- miRNA58 %>% 
  mutate(FC=as.character(FC)) %>% 
  mutate(FC=str_replace_all(FC, "_", ".")) %>% 
  rename(Sample.ID=FC)

names(miRNA58) <- str_replace_all(names(miRNA58), "\\.", "-")
miRNA58 <- miRNA58 %>% 
  rename(Sample.ID=`Sample-ID`)

############################## DEcircRNA ########################################
circ_mi<- CMM %>%
  filter(DEcircRNA=="up"|DEcircRNA=="down") %>% 
  select(circRNAID, miRNAID) %>%
  unique()
    

circ_mi_spearman <- c()
circ_mi_n <- dim(circ_mi)[1]

for(i in 1:circ_mi_n){
  
  circ_mi_One <- circ_mi[i,]
  
  circRNA_One <- circ60 %>% 
     select(Sample.ID, circ_mi_One$circRNAID) %>% 
     rename(circRNAID=circ_mi_One$circRNAID)

  miRNA_One <- miRNA58 %>% 
    select(Sample.ID, circ_mi_One$miRNAID) %>% 
    rename(miRNAID=circ_mi_One$miRNAID)

  circRNA_miRNA_One <- circRNA_One %>% 
    left_join(miRNA_One, by="Sample.ID")

  cor_circ_mi_rho <- cor.test(circRNA_miRNA_One$circRNAID, circRNA_miRNA_One$miRNAID, method="spearman")$estimate
  cor_circ_mi_less_pvalue <- cor.test(circRNA_miRNA_One$circRNAID, circRNA_miRNA_One$miRNAID, method="spearman", alternative = "less")$p.value
  cor_circ_mi_greater_pvalue <- cor.test(circRNA_miRNA_One$circRNAID, circRNA_miRNA_One$miRNAID, method="spearman", alternative = "greater")$p.value
  

  circ_mi_One <- circ_mi_One %>% 
    add_column(cor_circ_mi_rho, cor_circ_mi_less_pvalue, cor_circ_mi_greater_pvalue)

  circ_mi_spearman <- rbind(circ_mi_spearman, circ_mi_One)
}

############################## module_circRNA ########################################
module_circ_mi <- CMM %>%
  filter(str_detect(module_circRNA, '_')) %>% 
  #filter(is.na(DEcircRNA)) %>% 
  select(circRNAID, miRNAID) %>% 
  unique()


module_circ_mi_spearman <- c()
module_circ_mi_n <- dim(module_circ_mi)[1]

for(i in 1:module_circ_mi_n){
  
  circ_mi_One <- module_circ_mi[i,]
  
  circRNA_One <- circRNA %>% 
    select(Sample.ID, circ_mi_One$circRNAID) %>% 
    rename(circRNAID=circ_mi_One$circRNAID)
  

  miRNA_One <- miRNA %>% 
   select(Sample.ID, circ_mi_One$miRNAID) %>% 
   rename(miRNAID=circ_mi_One$miRNAID)
  
  circRNA_miRNA_One <- circRNA_One %>% 
    left_join(miRNA_One, by="Sample.ID")
  
  cor_circ_mi_rho <- cor.test(circRNA_miRNA_One$circRNAID, circRNA_miRNA_One$miRNAID, method="spearman")$estimate
  cor_circ_mi_less_pvalue <- cor.test(circRNA_miRNA_One$circRNAID, circRNA_miRNA_One$miRNAID, method="spearman", alternative = "less")$p.value
  cor_circ_mi_greater_pvalue <- cor.test(circRNA_miRNA_One$circRNAID, circRNA_miRNA_One$miRNAID, method="spearman", alternative = "greater")$p.value
  
  circ_mi_One <- circ_mi_One %>% 
    add_column(cor_circ_mi_rho, cor_circ_mi_less_pvalue, cor_circ_mi_greater_pvalue)
  
  module_circ_mi_spearman <- rbind(module_circ_mi_spearman, circ_mi_One)
}
#######################################################################################################
circRNA_miRNA_spearman <- rbind(circ_mi_spearman, module_circ_mi_spearman) %>% 
  unique()

############################################################################################################
write_xlsx(circRNA_miRNA_spearman,"output/circRNA_miRNA_spearman.xlsx")


  