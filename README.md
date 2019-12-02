### Geneme-wide, integrative analysis of circular RNA dysregulation and the corresponding circular RNA-microRNA-mRNA regulatory axes in autism
Chen et. al 

---
**Data produced in this study** 

| Raw data | Description |
|---|--- |
| Microarray_circARID1A_miR204-3p.xlsx | We knockdown circARID1A, overexpressed circARID1A and miR-204-3p in ReNcell, independently. The gene expression changes were exmined by microarray analysis. The microarray result was used to identify the expression changes of 171 predicted target genes by circARID1A and miR-204-3p. |                          |


---
All programming scripts used in this study were gathered in ASD_circ_R_codes Rproject repository. The input data for R scripts can be found in input or output folder. The ouput data from R scripts can be found in ouput folder. There are three main processes in our analyses. 

**Step1** : to detect DE-circRNAs by linear mixed effect (LME) model

**Step2** : to construct the circRNA-microRNA-mRNA relation

**Step3** : to calculate the correlation among circRNAs, microRNAs, and mRNAs

---
The above steps in details: 

**Step1_lme_run.R**

input: ```circRNA expression of 1060 events 2) host gene ENSG ID of 1060 circRNAs 3) characters of 134 individuals 4) mRNA expression of 134 individuals```

ouput: ```circ1060_DEG_Diagnosis_134s.csv```


**Step2.1_Relation_circRNA-miRNA.R**

input: ```DEcircRNAs, module circRNAs and their target miRNAs (RNA22_circRNA_miRNA_module.xlsx)```

output: ```circRNA_miRNA_relation.xlsx```


**Step2.2_Relation_circRNA-miRNA-mRNA.R**

input: ```circRNA_miRNA_relation.xlsx and miRNA target genes (Supplemental_Table S4_targets_of_58miRNAs.xlsx)```

output: ```circ_miRNA_mRNA_relation.xlsx and circ_miRNA_mRNA_relation_short.xlsx```


**Step3.1_Correlation_circRNA-miRNA.R**

input: ```circRNA and miRNA expreesion, circ_miRNA_mRNA_relation_short.xlsx```

ouput: ```circRNA_mRNA_spearman.xlsx```


**Step3.2_CorrelationmiRNA-mRNA.R**

input: ```miRNA and mRNA expression, circ_miRNA_mRNA_relation_short.xlsx```

output: ```miRNA_mRNA_spearman.xlsx```


**Step3.3.1_Correlation_DEcircRNA-mRNA.R**

input: ```DEcircRNA and mRNA expreesion, circ_miRNA_mRNA_relation_short.xlsx```

output: ```DEcircRNA_mRNA_spearm.xlsx```


**Step3.3.2_Correlation_module_circRNA-mRNA.R**

input: ```module circRNA and mRNA expreesion, circ_miRNA_mRNA_relation_short.xlsx```

output: ```module_circRNA_mRNA_spearman.xlsx```


**Step3.4_Correlation_circRNA-miRNA-mRNA.R**

input: ```circRNA-miRNA, miRNA-mRNA and circRNA-mRNA correlation testing results```

output: ```circRNA_miRNA_mRNA_spearman.xlsx```

