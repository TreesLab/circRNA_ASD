### Geneme-wide, integrative analysis of circular RNA dysregulation and the corresponding circular RNA-microRNA-mRNA regulatory axes in autism
Chen et al. 

---
**Data produced in this study** 

| Proceesed file | Description |
|---|--- |
| Microarray_circARID1A_miR204-3p.xlsx | We performed knockdown circARID1A, overexpressed circARID1A and miR-204-3p in ReNcell, independently. The gene expression changes were exmined by microarray analysis. The microarray result was used to screen 22,480 genes by circARID1A and miR-204-3p regulation. |


|Raw data| Description|
|---|---|
| ReN_KB_circARID1A.CEL.rar| knockdown circARID1A|
| ReN_KB_circARID1A_NC.CEL.rar | control for knocdown circARID1A |
| ReN_OE_circARID1A.CEL.rar | overexpressed circARID1A |
| ReN_OE_circARID1A_NC.CEL.rar | control for overexpressed circARID1A |
| ReN_OE_miR-204-3p.CEL.rar | overexpressed miR-204-3p |
| ReN_OE_miR-204-3p_NC.CEL.rar | control for overexpressed miR-204-3p | 


---
All programming scripts used in this study were gathered in ASD_circ_R_codes.Rproj repository. The input data for R scripts can be found in input or output folder. The ouput data from R scripts can be found in ouput folder. There are three main processes in our analyses. 

**Step1** : to detect DE-circRNAs by linear mixed effect (LME) model

**Step2** : to construct the circRNA-microRNA-mRNA relation

**Step3** : to calculate the correlation among circRNAs, microRNAs, and mRNAs

**Empirical gene enrichment analysis** : SFARI gene enrichment of circRNA-miRNA-mRNA interaction (Fig. 3B)  

---

**Network graphics** : using Cytoscape tool (shell code)
    
   to generate the up-regualted circRNA network (input files: up-node.txt and up-edge.xt)
   
     $./run-up.sh > up.xml 
     
   to generate the down-regulated circRNA network (input files: down-node.txt and down-edge.txt)
   
     $./run-down.sh > down.xml
     
The output files (up.xml and down.xml) can be opened via Cytoscape (httep://cytoscape.org/)

by click : File -> Import -> Network -> File -> Select "up.xml" or "down.xml".
 


---
Details of the ASD_circ_R_codes.Rproj: 

**Step1_lme_run.R**

input: 

          1) circRNA expression of 1060 events (circ1060_datRPM_134s.txt)
 
          2) host gene ENSG ID of 1060 circRNAs (circ1060_ENSG.txt) 
          
          3) characters of 134 individuals (datTraits_134s.txt) 
          
          4) mRNA expression of 134 individuals (datExpr_134s.txt)
    

ouput: ```circ1060_DEG_Diagnosis_134s.csv```


**Step2.1_Relation_circRNA-miRNA.R**

input: ```DEcircRNAs, module circRNAs and their target miRNAs (RNA22_circRNA_miRNA_module.xlsx)```

output: ```circRNA_miRNA_relation.xlsx```


**Step2.2_Relation_circRNA-miRNA-mRNA.R**

input: 
      
      1) circRNA_miRNA_relation.xlsx
      2) miRNA target genes (Supplemental_Table S4_targets_of_58miRNAs.xlsx)
    
output: ```circ_miRNA_mRNA_relation.xlsx and circ_miRNA_mRNA_relation_short.xlsx```


**Step3.1_Correlation_circRNA-miRNA.R**

input: 

     1) circRNA expression (circ1060_datRPM_73s.txt; circ60_indiv73.csv)
     3) miRNA expression (miRNA699_73s_exp.txt; miRNA58_indiv73.csv)
     2) circ_miRNA_mRNA_relation_short.xlsx
     

ouput: ```circRNA_mRNA_spearman.xlsx```


**Step3.2_Correlation_miRNA-mRNA.R**

input: 

     1) miRNA expression (miRNA58_indiv73.csv)
     2) mRNA expression (73s_normalized_log2_FPKM_miRNA_targetG_new.transpose)
     3) miRNA-mRNA relation (58miRNA_targets_ENSG.txt)

output: ```miRNA_mRNA_spearman.xlsx```


**Step3.3.1_Correlation_DEcircRNA-mRNA.R**

input: 
 
     1) circRNA expreesion (circ60_indiv73.txt)
     2) mRNA expression (73s_normalized_miRNA_targetG_new.transpose)

output: ```DEcircRNA_mRNA_spearman.xlsx```


**Step3.3.2_Correlation_module_circRNA-mRNA.R**

input: 
 
      1) circRNA expression (circRNA1060_73s_RPM.txt) 
      2) mRNA expreesion (73s_normalized_miRNA_targetG_new.transpose) 
      3) circ-miRNA-mRNA relation (mi-ci_sig_InModules_short.txt)

output: ```Module_circRNA_mRNA_spearman.xlsx```


**Step3.4_Correlation_circRNA-miRNA-mRNA.R**

input: 

       1) circRNA-miRNA correlation (circRNA_miRNA_spearman.xlsx)
       2) miRNA-mRNA correlation (miRNA_mRNA_sparman.xlsx)
       3) circRNA-mRNA correlation (DEcirc_mRNA_spearman.xlsx;Module_circ_mRNA_spearman.xlsx)
       4) circ-miRNA-mRNA relation (circ_miRNA_mRNA_relation.xlsx; 58miRNA_target_ENSG.txt)

output: 

       1) circRNA_miRNA_mRNA_spearman.xlsx
       2) sponge_circRNA_miRNA_mRNA_spearman.xlsx


**Empirical gene enrichment analysis: enrichment_permutation.R**

input: ```circRNA_target_other_diseases.xlsx```

output: ```permutation_17categories_100000out.xlsx```
