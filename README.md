### Geneme-wide, integrative analysis of circular RNA dysregulation and the corresponding circular RNA-microRNA-mRNA regulatory axes in autism
Chen et al. 

---
**Microarray data generated in this study** 
All the raw expression profiling by array are deposited into NCBI GEO database with accession number GSE145417.

We performed knockdown of circARID1A, overexpression of circARID1A and overexpression of miR-204-3p in ReNcell, independently. The 22,480 gene expression changes were examined by microarray analysis. The microarray result was used to screen gene expression changes by circARID1A and miR-204-3p regulation.

|Raw data| Description|
|---|---|
| ReN_KB_circARID1A.CEL.rar| knockdown of circARID1A|
| ReN_KB_circARID1A_NC.CEL.rar | negative control for knockdown of circARID1A |
| ReN_OE_circARID1A.CEL.rar | overexpression of circARID1A |
| ReN_OE_circARID1A_NC.CEL.rar | negative control for overexpression of circARID1A |
| ReN_OE_miR-204-3p.CEL.rar | overexpression of miR-204-3p |
| ReN_OE_miR-204-3p_NC.CEL.rar | negative control for overexpression of  miR-204-3p | 
| **Processed data** | **Description** |
| Microarray_circARID1A_miR204-3p.xlsx | The log2 fold change is calculated to compare gene expressions between the treatment an its negative control. The gene expression was calculated by the median value of the numerous probes in the same gene.  |


---
**circRNA-miRNA-mRNA regulation** (R code)

All programming scripts used in this study were gathered in ASD_R_codes.Rproj repository. The input data for R scripts can be found in input or output folder. The ouput data from R scripts can be found in ouput folder. There are four main processes in our analyses. 

**Step1** : to detect DE-circRNAs by linear mixed effect (LME) model

**Step2** : to construct the circRNA-microRNA-mRNA relation

**Step3** : to calculate the correlation among circRNAs, microRNAs, and mRNAs

**Empirical gene enrichment analysis** : to perform gene enrichment analysis and permuation test on targeted genes under circRNA-miRNA-mRNA interaction (Fig. 3B)  

---

**Network graphics Cytoscape** (shell code)

    
   to generate the up-regualted circRNA network (input files: up-node.txt and up-edge.txt)
   
     $./run-up.sh > up.xml 
     
   to generate the down-regulated circRNA network (input files: down-node.txt and down-edge.txt)
   
     $./run-down.sh > down.xml
     
The output file (up.xml or down.xml) can be open via Cytoscape (httep://cytoscape.org/)

by click : File -> Import -> Network -> File -> Select "up.xml" or "down.xml".
 


---
Details of the ASD_R_codes.Rproj: 

**Step1_lme_run.R**

input: 

          1) circRNA expression of 1060 events (circ1060_datRPM_134s.txt)
 
          2) host gene ENSG ID of 1060 circRNAs (circ1060_ENSG.txt) 
          
          3) characters of 134 individuals (datTraits_134s.txt) 
          
          4) mRNA expression of 134 individuals (datExpr_134s.txt)
    

ouput: 

          circ1060_DEG_Diagnosis_134s.csv


**Step2.1_Relation_circRNA-miRNA.R**

input: 

          DEcircRNAs, module circRNAs and their target miRNAs (RNA22_circRNA_miRNA_module.xlsx)

output: 

          circRNA_miRNA_relation.xlsx


**Step2.2_Relation_circRNA-miRNA-mRNA.R**

input: 
      
      1) circRNA_miRNA_relation.xlsx
      2) miRNA target genes (Supplemental_Table S4_targets_of_58miRNAs.xlsx)
    
output: 

      1) circ_miRNA_mRNA_relation.xlsx
      2) circ_miRNA_mRNA_relation_short.xlsx


**Step3.1_Correlation_circRNA-miRNA.R**

input: 

     1) circRNA expression (circ1060_datRPM_73s.txt; circ60_indiv73.csv)
     3) miRNA expression (miRNA699_73s_exp.txt; miRNA58_indiv73.csv)
     2) circ_miRNA_mRNA_relation_short.xlsx
     

ouput: 

     circRNA_miRNA_spearman.xlsx


**Step3.2_Correlation_miRNA-mRNA.R**

input: 

     1) miRNA expression (miRNA58_indiv73.csv)
     2) mRNA expression (73s_normalized_log2_FPKM_miRNA_targetG.transpose)
     3) miRNA-mRNA relation (58miRNA_targets_ENSG.txt)

output: 

     miRNA_mRNA_spearman.xlsx


**Step3.3.1_Correlation_DEcircRNA-mRNA.R**

input: 
 
     1) circRNA expreesion (circ60_indiv73.txt)
     2) mRNA expression (73s_normalized_miRNA_targetG.transpose)

output: 

     DEcircRNA_mRNA_spearman.txt


**Step3.3.2_Correlation_module_circRNA-mRNA.R**

input: 
 
      1) circRNA expression (circRNA1060_73s_RPM.txt) 
      2) mRNA expreesion (73s_normalized_miRNA_targetG_new.transpose) 
      3) circ-miRNA-mRNA relation (mi-ci_sig_InModules_short.txt)

output: 

      Module_circRNA_mRNA_spearman.txt


**Step3.4_Correlation_circRNA-miRNA-mRNA.R**

input: 

       1) circRNA-miRNA correlation (circRNA_miRNA_spearman.xlsx)
       2) miRNA-mRNA correlation (miRNA_mRNA_spearman.xlsx)
       3) circRNA-mRNA correlation (DEcirc_mRNA_spearman.txt; Module_circ_mRNA_spearman.txt)
       4) circ-miRNA-mRNA relation (circ_miRNA_mRNA_relation.xlsx; 58miRNA_target_ENSG.txt)

output: 

       1) circRNA_miRNA_mRNA_spearman.xlsx
       2) sponge_circRNA_miRNA_mRNA_spearman.xlsx


**Empirical gene enrichment analysis: enrichment_permutation.R**

input: 

       circRNA_target_other_diseases.xlsx

output: 

       permutation_17categories_100000out.xlsx
       
----
 **Miscellaneous**
 
 Two files cannnot be found in the circRNA_ASD GitHub repository due to over GitHub upload limit (50 Mb).
 Users can download them from our FTP (ftp://treeslab1.genomics.sinica.edu.tw/treeslabtools/circRNA_ASD).
      
      1) input/datExpr_134s.txt
      2) ouput/DEcirc_mRNA_spearman.txt
      
