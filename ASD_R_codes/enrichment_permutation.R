if (!require(readxl)) install.packages('readxl')
if (!require(tidyverse)) install.packages('tidyverse')
if (!require(writexl)) install.packages('writexl')

library(tidyverse)
library(readxl)
library(writexl)

rm(list=ls(all=TRUE))
############################# input files #########################################

diseases <- read_excel("input/circRNA_target_other_diseases.xlsx")

##################################################################################

protein_coding <- diseases %>% 
  filter(`Gene type`=="protein_coding")

protein_coding_short <- protein_coding %>% 
  select(`Gene name`, 
         `Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`,
         SFARI...9,
         `TopSFARI (score=1,2,3,syndromic)`,
         Autism_KB,
         iPSD,
         ePSD,
         epilepsy,
         SchizophreniaGWAS,
         Parkinston,
         Huntington,
         Alzheimer,
         AmoythrophicLateralSclerosis,
         IntellectualDisability,
         Neurogenerative,
         Height,
         FMRP_target,
         HuR_target,
         RBFOX1_target)


protein_coding_short <- protein_coding_short %>% 
  replace_na(list(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`=0,
                  SFARI...9=0,
                  `TopSFARI (score=1,2,3,syndromic)`=0,
                  Autism_KB=0,
                  iPSD=0,
                  ePSD=0,
                  epilepsy=0,
                  SchizophreniaGWAS=0,
                  Parkinston=0,
                  Huntington=0,
                  Alzheimer=0,
                  AmoythrophicLateralSclerosis=0,
                  IntellectualDisability=0,
                  Neurogenerative=0,
                  Height=0,
                  FMRP_target=0,
                  HuR_target=0,
                  RBFOX1_target=0
  ))


#################################################################################################
#SFARI     
SFARI_2C <- rep(NA,3)

SFARI_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, SFARI...9==1) %>% 
  count() %>% 
  unlist()

SFARI_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, SFARI...9==0) %>% 
  count() %>% 
  unlist()

SFARI_2C[3] <- SFARI_2C[1]/(SFARI_2C[1]+SFARI_2C[2])

#TopSFARI     
TopSFARI_2C <- rep(NA,3)

TopSFARI_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, `TopSFARI (score=1,2,3,syndromic)`==1) %>% 
  count() %>% 
  unlist()

TopSFARI_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, `TopSFARI (score=1,2,3,syndromic)`==0) %>% 
  count() %>% 
  unlist()

TopSFARI_2C[3] <- TopSFARI_2C[1]/(TopSFARI_2C[1]+TopSFARI_2C[2])

#AutismKB     
AutismKB_2C <- rep(NA,3)

AutismKB_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, Autism_KB==1) %>% 
  count() %>% 
  unlist()

AutismKB_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, Autism_KB==0) %>% 
  count() %>% 
  unlist()

AutismKB_2C[3] <- AutismKB_2C[1]/(AutismKB_2C[1]+AutismKB_2C[2])

#iPSD     
iPSD_2C <- rep(NA,3)

iPSD_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, iPSD==1) %>% 
  count() %>% 
  unlist()

iPSD_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, iPSD==0) %>% 
  count() %>% 
  unlist()

iPSD_2C[3] <- iPSD_2C[1]/(iPSD_2C[1]+iPSD_2C[2])

#ePSD     
ePSD_2C <- rep(NA,3)

ePSD_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, ePSD==1) %>% 
  count() %>% 
  unlist()

ePSD_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, ePSD==0) %>% 
  count() %>% 
  unlist()

ePSD_2C[3] <- ePSD_2C[1]/(ePSD_2C[1]+ePSD_2C[2])

#epilepsy   
epilepsy_2C <- rep(NA,3)

epilepsy_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, epilepsy==1) %>% 
  count() %>% 
  unlist()

epilepsy_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, epilepsy==0) %>% 
  count() %>% 
  unlist()

epilepsy_2C[3] <- epilepsy_2C[1]/(epilepsy_2C[1]+epilepsy_2C[2])

#Schizophrenia  
Schizophrenia_2C <- rep(NA,3)

Schizophrenia_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, SchizophreniaGWAS==1) %>% 
  count() %>% 
  unlist()

Schizophrenia_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, SchizophreniaGWAS==0) %>% 
  count() %>% 
  unlist()

Schizophrenia_2C[3] <- Schizophrenia_2C[1]/(Schizophrenia_2C[1]+Schizophrenia_2C[2])

#Parkinston
Parkinston_2C <- rep(NA,3)

Parkinston_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, Parkinston==1) %>% 
  count() %>% 
  unlist()

Parkinston_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, Parkinston==0) %>% 
  count() %>% 
  unlist()

Parkinston_2C[3] <- Parkinston_2C[1]/(Parkinston_2C[1]+Parkinston_2C[2])

#Huntington 
Huntington_2C <- rep(NA,3)

Huntington_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, Huntington==1) %>% 
  count() %>% 
  unlist()

Huntington_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, Huntington==0) %>% 
  count() %>% 
  unlist()

Huntington_2C[3] <- Huntington_2C[1]/(Huntington_2C[1]+Huntington_2C[2])

#Alzheimer 
Alzheimer_2C <- rep(NA,3)

Alzheimer_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, Alzheimer==1) %>% 
  count() %>% 
  unlist()

Alzheimer_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, Alzheimer==0) %>% 
  count() %>% 
  unlist()

Alzheimer_2C[3] <- Alzheimer_2C[1]/(Alzheimer_2C[1]+Alzheimer_2C[2])

#AmoythrophicLateralSclerosis 
AmoythrophicLateralSclerosis_2C <- rep(NA,3)

AmoythrophicLateralSclerosis_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, AmoythrophicLateralSclerosis==1) %>% 
  count() %>% 
  unlist()

AmoythrophicLateralSclerosis_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, AmoythrophicLateralSclerosis==0) %>% 
  count() %>% 
  unlist()

AmoythrophicLateralSclerosis_2C[3] <- AmoythrophicLateralSclerosis_2C[1]/(AmoythrophicLateralSclerosis_2C[1]+AmoythrophicLateralSclerosis_2C[2])

#IntellectualDisability 
IntellectualDisability_2C <- rep(NA,3)

IntellectualDisability_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, IntellectualDisability==1) %>% 
  count() %>% 
  unlist()

IntellectualDisability_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, IntellectualDisability==0) %>% 
  count() %>% 
  unlist()

IntellectualDisability_2C[3] <- IntellectualDisability_2C[1]/(IntellectualDisability_2C[1]+IntellectualDisability_2C[2])

#Neurogenerative 
Neurogenerative_2C <- rep(NA,3)

Neurogenerative_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, Neurogenerative==1) %>% 
  count() %>% 
  unlist()

Neurogenerative_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, Neurogenerative==0) %>% 
  count() %>% 
  unlist()

Neurogenerative_2C[3] <- Neurogenerative_2C[1]/(Neurogenerative_2C[1]+Neurogenerative_2C[2])

#Height 
Height_2C <- rep(NA,3)

Height_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, Height==1) %>% 
  count() %>% 
  unlist()

Height_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, Height==0) %>% 
  count() %>% 
  unlist()

Height_2C[3] <- Height_2C[1]/(Height_2C[1]+Height_2C[2])

#FMRP_target 
FMRP_target_2C <- rep(NA,3)

FMRP_target_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, FMRP_target==1) %>% 
  count() %>% 
  unlist()

FMRP_target_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, FMRP_target==0) %>% 
  count() %>% 
  unlist()

FMRP_target_2C[3] <- FMRP_target_2C[1]/(FMRP_target_2C[1]+FMRP_target_2C[2])

#HuR_target 
HuR_target_2C <- rep(NA,3)

HuR_target_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, HuR_target==1) %>% 
  count() %>% 
  unlist()

HuR_target_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, HuR_target==0) %>% 
  count() %>% 
  unlist()

HuR_target_2C[3] <- HuR_target_2C[1]/(HuR_target_2C[1]+HuR_target_2C[2])

#RBFOX1_target 
RBFOX1_target_2C <- rep(NA,3)

RBFOX1_target_2C[1] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, RBFOX1_target==1) %>% 
  count() %>% 
  unlist()

RBFOX1_target_2C[2] <- protein_coding_short %>% 
  filter(`Targets of the identified Asd-associated circRNA-miRNA-mRNA axes`==1, RBFOX1_target==0) %>% 
  count() %>% 
  unlist()

RBFOX1_target_2C[3] <- RBFOX1_target_2C[1]/(RBFOX1_target_2C[1]+RBFOX1_target_2C[2])


#################################################################################################
#permutation
permut_n <- 100000
SFARI_2CP <- matrix(NA, ncol=3, nrow=permut_n)
TopSFARI_2CP <- matrix(NA, ncol=3, nrow=permut_n)
AutismKB_2CP <- matrix(NA, ncol=3, nrow=permut_n)
iPSD_2CP <- matrix(NA, ncol=3, nrow=permut_n)
ePSD_2CP <- matrix(NA, ncol=3, nrow=permut_n)
epilepsy_2CP <- matrix(NA, ncol=3, nrow=permut_n)
Schizophrenia_2CP <- matrix(NA, ncol=3, nrow=permut_n)
Parkinston_2CP <- matrix(NA, ncol=3, nrow=permut_n)
Huntington_2CP <- matrix(NA, ncol=3, nrow=permut_n)
Alzheimer_2CP <- matrix(NA, ncol=3, nrow=permut_n)
AmoythrophicLateralSclerosis_2CP <- matrix(NA, ncol=3, nrow=permut_n)
IntellectualDisability_2CP <- matrix(NA, ncol=3, nrow=permut_n)
Neurogenerative_2CP <- matrix(NA, ncol=3, nrow=permut_n)
Height_2CP <- matrix(NA, ncol=3, nrow=permut_n)
FMRP_target_2CP <- matrix(NA, ncol=3, nrow=permut_n)
HuR_target_2CP <- matrix(NA, ncol=3, nrow=permut_n)
RBFOX1_target_2CP <- matrix(NA, ncol=3, nrow=permut_n)


for(i in 1:permut_n){
  
   protein_coding_sample <- sample_n(protein_coding_short, 2299)

   #SFARI
   SFARI_2CP[i, 1] <- protein_coding_sample %>% 
     filter(SFARI...9==1) %>% 
     count() %>% 
     unlist()

   SFARI_2CP[i, 2] <- protein_coding_sample %>% 
     filter(SFARI...9==0) %>% 
     count() %>% 
     unlist()

   SFARI_2CP[i, 3] <- SFARI_2CP[i,1]/(SFARI_2CP[i,1]+SFARI_2CP[i,2])
   
   #TopSFARI
   TopSFARI_2CP[i, 1] <- protein_coding_sample %>% 
     filter(`TopSFARI (score=1,2,3,syndromic)`==1) %>% 
     count() %>% 
     unlist()
   
   TopSFARI_2CP[i, 2] <- protein_coding_sample %>% 
     filter(`TopSFARI (score=1,2,3,syndromic)`==0) %>% 
     count() %>% 
     unlist()
   
   TopSFARI_2CP[i, 3] <- TopSFARI_2CP[i,1]/(TopSFARI_2CP[i,1]+TopSFARI_2CP[i,2])
   
   
   #AutismKB
   AutismKB_2CP[i, 1] <- protein_coding_sample %>% 
     filter(Autism_KB==1) %>% 
     count() %>% 
     unlist()
   
   AutismKB_2CP[i, 2] <- protein_coding_sample %>% 
     filter(Autism_KB==0) %>% 
     count() %>% 
     unlist()
   
   AutismKB_2CP[i, 3] <- AutismKB_2CP[i,1]/(AutismKB_2CP[i,1]+AutismKB_2CP[i,2])
   
   
   #iPSD
   iPSD_2CP[i, 1] <- protein_coding_sample %>% 
     filter(iPSD==1) %>% 
     count() %>% 
     unlist()
   
   iPSD_2CP[i, 2] <- protein_coding_sample %>% 
     filter(iPSD==0) %>% 
     count() %>% 
     unlist()
   
   iPSD_2CP[i, 3] <- iPSD_2CP[i,1]/(iPSD_2CP[i,1]+iPSD_2CP[i,2])
   
   
   #ePSD
   ePSD_2CP[i, 1] <- protein_coding_sample %>% 
     filter(ePSD==1) %>% 
     count() %>% 
     unlist()
   
   ePSD_2CP[i, 2] <- protein_coding_sample %>% 
     filter(ePSD==0) %>% 
     count() %>% 
     unlist()
   
   ePSD_2CP[i, 3] <- ePSD_2CP[i,1]/(ePSD_2CP[i,1]+ePSD_2CP[i,2])
   
   
   #epilepsy
   epilepsy_2CP[i, 1] <- protein_coding_sample %>% 
     filter(epilepsy==1) %>% 
     count() %>% 
     unlist()
   
   epilepsy_2CP[i, 2] <- protein_coding_sample %>% 
     filter(epilepsy==0) %>% 
     count() %>% 
     unlist()
   
   epilepsy_2CP[i, 3] <- epilepsy_2CP[i,1]/(epilepsy_2CP[i,1]+epilepsy_2CP[i,2])
   
   
   #Schizophrenia
   Schizophrenia_2CP[i, 1] <- protein_coding_sample %>% 
     filter(SchizophreniaGWAS==1) %>% 
     count() %>% 
     unlist()
   
   Schizophrenia_2CP[i, 2] <- protein_coding_sample %>% 
     filter(SchizophreniaGWAS==0) %>% 
     count() %>% 
     unlist()
   
   Schizophrenia_2CP[i, 3] <- Schizophrenia_2CP[i,1]/(Schizophrenia_2CP[i,1]+Schizophrenia_2CP[i,2])
   
   
   #Parkinston
   Parkinston_2CP[i, 1] <- protein_coding_sample %>% 
     filter(Parkinston==1) %>% 
     count() %>% 
     unlist()
   
   Parkinston_2CP[i, 2] <- protein_coding_sample %>% 
     filter(Parkinston==0) %>% 
     count() %>% 
     unlist()
   
   Parkinston_2CP[i, 3] <- Parkinston_2CP[i,1]/(Parkinston_2CP[i,1]+Parkinston_2CP[i,2])
   
   
   #Huntington
   Huntington_2CP[i, 1] <- protein_coding_sample %>% 
     filter(Huntington==1) %>% 
     count() %>% 
     unlist()
   
   Huntington_2CP[i, 2] <- protein_coding_sample %>% 
     filter(Huntington==0) %>% 
     count() %>% 
     unlist()
   
   Huntington_2CP[i, 3] <- Huntington_2CP[i,1]/(Huntington_2CP[i,1]+Huntington_2CP[i,2])
   
   
   #Alzheimer
   Alzheimer_2CP[i, 1] <- protein_coding_sample %>% 
     filter(Alzheimer==1) %>% 
     count() %>% 
     unlist()
   
   Alzheimer_2CP[i, 2] <- protein_coding_sample %>% 
     filter(Alzheimer==0) %>% 
     count() %>% 
     unlist()
   
   Alzheimer_2CP[i, 3] <- Alzheimer_2CP[i,1]/(Alzheimer_2CP[i,1]+Alzheimer_2CP[i,2])
   
   
   #AmoythrophicLateralSclerosis
   AmoythrophicLateralSclerosis_2CP[i, 1] <- protein_coding_sample %>% 
     filter(AmoythrophicLateralSclerosis==1) %>% 
     count() %>% 
     unlist()
   
   AmoythrophicLateralSclerosis_2CP[i, 2] <- protein_coding_sample %>% 
     filter(AmoythrophicLateralSclerosis==0) %>% 
     count() %>% 
     unlist()
   
   AmoythrophicLateralSclerosis_2CP[i, 3] <- AmoythrophicLateralSclerosis_2CP[i,1]/(AmoythrophicLateralSclerosis_2CP[i,1]+AmoythrophicLateralSclerosis_2CP[i,2])
   
   
   #IntellectualDisability
   IntellectualDisability_2CP[i, 1] <- protein_coding_sample %>% 
     filter(IntellectualDisability==1) %>% 
     count() %>% 
     unlist()
   
   IntellectualDisability_2CP[i, 2] <- protein_coding_sample %>% 
     filter(IntellectualDisability==0) %>% 
     count() %>% 
     unlist()
   
   IntellectualDisability_2CP[i, 3] <- IntellectualDisability_2CP[i,1]/(IntellectualDisability_2CP[i,1]+IntellectualDisability_2CP[i,2])
   
   
   #Neurogenerative
   Neurogenerative_2CP[i, 1] <- protein_coding_sample %>% 
     filter(Neurogenerative==1) %>% 
     count() %>% 
     unlist()
   
   Neurogenerative_2CP[i, 2] <- protein_coding_sample %>% 
     filter(Neurogenerative==0) %>% 
     count() %>% 
     unlist()
   
   Neurogenerative_2CP[i, 3] <- Neurogenerative_2CP[i,1]/(Neurogenerative_2CP[i,1]+Neurogenerative_2CP[i,2])
   
   
   #Height
   Height_2CP[i, 1] <- protein_coding_sample %>% 
     filter(Height==1) %>% 
     count() %>% 
     unlist()
   
   Height_2CP[i, 2] <- protein_coding_sample %>% 
     filter(Height==0) %>% 
     count() %>% 
     unlist()
   
   Height_2CP[i, 3] <- Height_2CP[i,1]/(Height_2CP[i,1]+Height_2CP[i,2])
   
   
   #FMRP_target
   FMRP_target_2CP[i, 1] <- protein_coding_sample %>% 
     filter(FMRP_target==1) %>% 
     count() %>% 
     unlist()
   
   FMRP_target_2CP[i, 2] <- protein_coding_sample %>% 
     filter(FMRP_target==0) %>% 
     count() %>% 
     unlist()
   
   FMRP_target_2CP[i, 3] <- FMRP_target_2CP[i,1]/(FMRP_target_2CP[i,1]+FMRP_target_2CP[i,2])
   
   
   #HuR_target
   HuR_target_2CP[i, 1] <- protein_coding_sample %>% 
     filter(HuR_target==1) %>% 
     count() %>% 
     unlist()
   
   HuR_target_2CP[i, 2] <- protein_coding_sample %>% 
     filter(HuR_target==0) %>% 
     count() %>% 
     unlist()
   
   HuR_target_2CP[i, 3] <- HuR_target_2CP[i,1]/(HuR_target_2CP[i,1]+HuR_target_2CP[i,2])
   
   
   #RBFOX1_target
   RBFOX1_target_2CP[i, 1] <- protein_coding_sample %>% 
     filter(RBFOX1_target==1) %>% 
     count() %>% 
     unlist()
   
   RBFOX1_target_2CP[i, 2] <- protein_coding_sample %>% 
     filter(RBFOX1_target==0) %>% 
     count() %>% 
     unlist()
   
   RBFOX1_target_2CP[i, 3] <- RBFOX1_target_2CP[i,1]/(RBFOX1_target_2CP[i,1]+RBFOX1_target_2CP[i,2])
}


SFARI_permuP <- sum(1*(SFARI_2CP[,3] > SFARI_2C[3]))
TopSFARI_permuP <- sum(1*(TopSFARI_2CP[,3] > TopSFARI_2C[3]))
AutismKB_permuP <- sum(1*(AutismKB_2CP[,3] > AutismKB_2C[3]))
iPSD_permuP <- sum(1*(iPSD_2CP[,3] > iPSD_2C[3]))
ePSD_permuP <- sum(1*(ePSD_2CP[,3] > ePSD_2C[3]))
epilepsy_permuP <- sum(1*(epilepsy_2CP[,3] > epilepsy_2C[3]))
Schizophrenia_permuP <- sum(1*(Schizophrenia_2CP[,3] > Schizophrenia_2C[3]))
Parkinston_permuP <- sum(1*(Parkinston_2CP[,3] > Parkinston_2C[3]))
Huntington_permuP <- sum(1*(Huntington_2CP[,3] > Huntington_2C[3]))
Alzheimer_permuP <- sum(1*(Alzheimer_2CP[,3] > Alzheimer_2C[3]))
AmoythrophicLateralSclerosis_permuP <- sum(1*(AmoythrophicLateralSclerosis_2CP[,3] > AmoythrophicLateralSclerosis_2C[3]))
IntellectualDisability_permuP <- sum(1*(IntellectualDisability_2CP[,3] > IntellectualDisability_2C[3]))
Neurogenerative_permuP <- sum(1*(Neurogenerative_2CP[,3] > Neurogenerative_2C[3]))
Height_permuP <- sum(1*(Height_2CP[,3] > Height_2C[3]))
FMRP_target_permuP <- sum(1*(FMRP_target_2CP[,3] > FMRP_target_2C[3]))
HuR_target_permuP <- sum(1*(HuR_target_2CP[,3] > HuR_target_2C[3]))
RBFOX1_target_permuP <- sum(1*(RBFOX1_target_2CP[,3] > RBFOX1_target_2C[3]))


permutation_17categories <- rbind(SFARI_permuP,
                                 TopSFARI_permuP,
                                 AutismKB_permuP,
                                 iPSD_permuP,
                                 ePSD_permuP,
                                 epilepsy_permuP,
                                 Schizophrenia_permuP,
                                 Parkinston_permuP,
                                 Huntington_permuP,
                                 Alzheimer_permuP,
                                 AmoythrophicLateralSclerosis_permuP,
                                 IntellectualDisability_permuP,
                                 Neurogenerative_permuP,
                                 Height_permuP, 
                                 FMRP_target_permuP,
                                 HuR_target_permuP,
                                 RBFOX1_target_permuP)

categories <- rownames(permutation_17categories)
colnames(permutation_17categories) <-c("permutation_count")


permutation_17categories_out <- cbind(categories, permutation_17categories) %>% 
  as_tibble() 

permutation_17categories_out$permutation_count <- as.integer(permutation_17categories_out$permutation_count)

permutation_17categories_out <- permutation_17categories_out %>% 
  mutate(permutation_pvalue=permutation_count/permut_n)

write_xlsx(permutation_17categories_out,"output/permutation_17categories_100000out.xlsx")

