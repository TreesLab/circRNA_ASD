### Geneme-wide, integrative analysis of circular RNA dysregulation and the corresponding circular RNA-microRNA-mRNA regulatory axes in autism
---
### Citation

Chen, Y. J., Chen, C. Y., Mai, T. L., Chuang, C. F., Chen, Y. C., Gupta, S. K., . . . Chuang, T. J. (2020). Genome-wide integrative analysis of circular RNA dysregulation and the corresponding circular RNA-microRNA-mRNA regulatory axes in autism. Genome Res. doi:10.1101/gr.255463.119


---
The scripts used in this study include two parts: 
1. Identification of DE-circRNAs and ASD-associated circRNA-miRNA-mRNA regulatory axes
2. Visualization of the identified circRNA-miRNA-mRNA axes by Cytoscape

### 1. Identification of DE-circRNAs and ASD-associated circRNA-miRNA-mRNA regulatory axes (R code)

All scripts in this part were gathered in the ASD_R_codes folder. The results can be found in the output folder. This part contains four main steps:

**Step1: detecting DE-circRNAs by a linear mixed effects (LME) model**

One R script: Step1_lme_run.R

**Step1_lme_run.R**

  Input:

        (1) circRNA expression of the 1,060 events (circ1060_datRPM_134s.txt)
        (2) the mapping table of the host gene IDs vs. the 1,060 circRNAs (circ1060_ENSG.txt) 
        (3) features of the 134 samples examined (datTraits_134s.txt) 
        (4) expression of all Ensembl-annotated genes in 134 samples (datExpr_134s.txt)
        
  Output:

        circ1060_DEG_Diagnosis_134s.csv

**Step2: identifying circRNA-miRNA-mRNA regulatory axes by integrating the circRNA-miRNA interactions with the miRNA-mRNA interactions according to the common miRNA target sites of the circRNAs and mRNAs.**

Two R scripts: 

Step2.1_Relation_circRNA-miRNA.R 

Step2.2_Relation_circRNA-miRNA-mRNA.R

**Step2.1_Relation_circRNA-miRNA.R**

  Input:
   
        circRNAs (DE-circRNAs and circRNAs from DE-modules) and the corresponding miRNAs with miRNA target sites in the circle sequences of the circRNAs (RNA22_circRNA_miRNA_module.xlsx)
   
  Output:
   
        circRNA_miRNA_relation.xlsx

**Step2.2_Relation_circRNA-miRNA-mRNA.R**

   Input:
   
        (1) circRNA_miRNA_relation.xlsx
        (2) miRNA target genes (Supplemental_TableS4_targets_of_58miRNAs.xlsx)
        
   Output: 
    
        (1) circ_miRNA_mRNA_relation.xlsx
        (2) circ_miRNA_mRNA_relation_short.xlsx

**Step3: calculating Spearman’s rank coefficients of correlation between circRNA, microRNA, and mRNA expression**

Five R scripts: 

Step3.1_Correlation_circRNA-miRNA.R 

Step3.2_Correlation_miRNA-mRNA.R 

Step3.3.1_Correlation_DEcircRNA-mRNA.R

Step3.3.2_Correlation_module_circRNA-mRNA.R

Step3.4_Correlation_circRNA-miRNA-mRNA.R

**Step3.1_Correlation_circRNA-miRNA.R**

  Input:
  
        (1) circRNA expression (circ1060_datRPM_73s.txt; circ60_indiv73.csv)
        (2) miRNA expression (miRNA699_73s_exp.txt; miRNA58_indiv73.csv)
        (3) circ_miRNA_mRNA_relation_short.xlsx
        
  Output:
   
        circRNA_miRNA_spearman.xlsx

**Step3.2_Correlation_miRNA-mRNA.R**

   Input:
    
        (1) miRNA expression (miRNA58_indiv73.csv)
        (2) mRNA expression (73s_normalized_log2_FPKM_miRNA_targetG.transpose)
        (3) miRNA-mRNA relation (58miRNA_targets_ENSG.txt)
        
   Output:
   
        miRNA_mRNA_spearman.xlsx

**Step3.3.1_Correlation_DEcircRNA-mRNA.R**

   Input:
   
       (1) DE-circRNA expression (circ60_indiv73.txt)
       (2) mRNA expression (73s_normalized_miRNA_targetG.transpose)
       
   Output:
   
       DEcirc_mRNA_spearman.txt

**Step3.3.2_Correlation_module_circRNA-mRNA.R**

   Input:
   
       (1) expression of circRNAs from DE-modules (circRNA1060_73s_RPM.txt) 
       (2) mRNA expression (73s_normalized_miRNA_targetG_new.transpose) 
       (3) circRNA (from DE-modules)-mRNA relation (mi-ci_sig_InModules_short.txt)
       
   Output:
   
       Module_circRNA_mRNA_spearman.txt

**Step3.4_Correlation_circRNA-miRNA-mRNA.R**

   Input:
   
        (1) circRNA-miRNA correlation (circRNA_miRNA_spearman.xlsx)
        (2) miRNA-mRNA correlation (miRNA_mRNA_spearman.xlsx)
        (3) circRNA-mRNA correlation (DEcirc_mRNA_spearman.txt; Module_circ_mRNA_spearman.txt)
        (4) circRNA-miRNA-mRNA relation (circ_miRNA_mRNA_relation.xlsx; 58miRNA_target_ENSG.txt)
        
  Output:
  
       (1) circRNA_miRNA_mRNA_spearman.xlsx
       (2) sponge_circRNA_miRNA_mRNA_spearman.xlsx

**Step4: performing gene enrichment analysis and permutation test (Fig. 3B) on the target genes of the identified circRNA-miRNA-mRNA interactions**  

One R script: enrichment_permutation.R 

**enrichment_permutation.R**

  Input:
  
    targets of the identified circRNA-miRNA-mRNA interactions vs. diseases (circRNA_target_other_diseases.xlsx)
    
  Output:
  
        permutation_17categories_100000out.xlsx

Since the sizes of the files (datExpr_134s.txt and DEcirc_mRNA_spearman.txt) are over the limitation of GitHub (50Mb), we deposited these two files in our FTP site at ftp://treeslab1.genomics.sinica.edu.tw/treeslabtools/circRNA_ASD.

### 2. Network graphics Cytoscape (shell code)

Two shell scripts:

run-up.sh

run-down.sh

**2.1 generating the upregulated circRNA network (Figure 3E)**

 (input files: up-node.txt and up-edge.txt)
 
    $./run-up.sh > up.xml

**2.2 generating the downregulated circRNA network (Supplementary Figure 6)**

  (input files: down-node.txt and down-edge.txt)
  
    $./run-down.sh > down.xml

The output file (up.xml or down.xml) can be opened via Cytoscape (httep://cytoscape.org/) by click: File -> Import -> Network -> File -> Select "up.xml" or "down.xml".
