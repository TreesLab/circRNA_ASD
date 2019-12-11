if (!require(nlme)) install.packages('nlme')
if (!require(tidyverse)) install.packages('tidyverse')
if (!require(data.table)) installed.packages('data.table')

library(nlme)
library(tidyverse)
library(data.table)

rm(list=ls(all=TRUE))
setDTthreads(threads = 4)

############################################## input files ################################################################################
# input: circRNA expression of 1060 events
datRPM <- read.table("input/circ1060_datRPM_134s.txt", sep="\t", header=T)

# input: host gene ENSG ID of 1060 circRNAs
ENSG_circID <- read.table("input/circ1060_ENSG.txt", sep="\t", header=T)

# input: characters of 134 individuals
datTraits <- read.table("input/datTraits_134s.txt", sep="\t", header=TRUE)

# input: mRNA expression of 134 individuals
datExpr <- data.table(fread("input/datExpr_134s.txt"))

#############################################reformat inputa ###########################################################################
# define data format of input files
datRPM <- as_tibble(datRPM)
datTraits <- as_tibble(datTraits)
datExpr <- as_tibble(datExpr)
ENSG_circID <- as_tibble(ENSG_circID)

############################################### runlme function ##########################################################################
# create a function for one circRNA to run the linear mixed-effecs models 
# report Beta values, standard error, and P values for the diagnosis (ASD/CTL) effect

runlme = function(circID){
  oneRPM <- datRPM %>% 
    select(ID,circID) %>% 
    rename(circID=circID)

  Host_genename <- ENSG_circID %>% 
    select(circID)
  Host_genename <- as.character(unlist(Host_genename))
  Hostgene <- datExpr[,c("ID1", Host_genename)] %>% 
    mutate_at(vars(ID1),as.factor) %>% 
    rename(Hostgene=matches("ENSG"))

  one_dat <- oneRPM %>% 
    left_join(Hostgene, by=c("ID" = "ID1")) %>%  
    left_join(datTraits, by="ID")
  one_dat$Diagnosis <- relevel(one_dat$Diagnosis, ref ="CTL")

  flme <- lme(asin(circID) ~ Diagnosis + Age + Sex + Region + RIN + SeqBatch + BrainBank + Hostgene , random = ~1|IndvID, data=one_dat, na.action = na.exclude)
  slme <- summary(flme)
  effect_lme <- rownames(slme$tTable)
  
  output_lme <- as_tibble(slme$tTable) %>% 
    add_column(effect_lme) %>% 
    select(effect_lme, everything()) %>% 
    filter(effect_lme=="DiagnosisASD")
  
  output_lme
}

############################################### run LME for 1060 circRNAs #######################################################################

DE_Diagnosis <- data.frame(circID=NA, Beta=NA, StdErr=NA, Pval=NA)


numCirc <- ncol(datRPM)-1
circV <- colnames(datRPM)

for (i in 1:numCirc){
  
  circID <- circV[i+1]
  
  result <- try(runlme(circID), silent=F)
  if(length(result) == 6){

    Beta_Diagnosis <- result$Value
    StdErr_Diagnosis <- result$Std.Error
    Pval_Diagnosis <- result$`p-value`
   } else{
    cat('Error in LME for circRNA', circID, '\n')
    cat('Setting Beta value=0, StdErr=Inf, and Pval=1\n')
    Beta_Diagnosis <- 0
    StdErr_Diagnosis <- Inf
    Pval_Diagnosis <- 1
  }
  
  DE_Diagnosis[i, "circID"] <- circID
  DE_Diagnosis[i, "Beta"] <- Beta_Diagnosis
  DE_Diagnosis[i, "StdErr"] <- StdErr_Diagnosis
  DE_Diagnosis[i, "Pval"] <- Pval_Diagnosis
    
}

############################################### multiple correction ############################################################################
# perform FDR adjustment using Benjamini-Hochberg correction

DE_Diagnosis$BH_adjPval = p.adjust(DE_Diagnosis$Pval, method="BH", n=nrow(DE_Diagnosis))

##################################################### ouput ####################################################################################
# write out the LME analysis result in CSV format

write_csv(DE_Diagnosis, "output/circ1060_DEG_Diagnosis_134s.csv")


















