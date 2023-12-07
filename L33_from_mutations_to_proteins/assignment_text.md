# Assignment: From mutation to protein structure

This assignment is designed to enhance student skills in bioinformatics analysis, integrating genomic and transcriptomic data to gain insights into genetic variations and their potential functional impacts. 


## Objective:

The goal of this assignment is to explore omics datasets, including re-sequencing and RNAseq ones. The focus will be on running the nf-core pipelines, sarek and rnaseq to carry on the variant calling and transcript quantification, respectively.

Additionally, the potential impact of found mutations on the protein structure and function will be explored by mining the AlphaMissense resource.

## Datasets:

- Re-sequencing and RNAseq: ```https://github.com/santorsola-teaching/datasets_lesson33```
- Updated references: ```https://github.com/lescai-teaching/datasets_reference_only.git```


## Tasks:

### 1. Variant calling and annotation

Use nf-core/sarek to perform the joint variant calling of case and control samples, by haplotypecaller, and snpeff to annotate variants. 
After you need to select the most relevant mutations in the case sample versus control.

- Tool: ```nf-core/sarek```

### 2. Quantification of transcript expression
Use nf-core/rnaseq to estimate the read counts by salmon pseudo-alignment.


- Tool: ```nf-core/rnaseq```

### 3. Identification of Differentially Expressed Genes:

Employ DESeq2 to identify genes that exhibit differential expression in the RNAseq dataset, and generate visualizations (e.g., heatmaps) to illustrate differential expression patterns.

- Tool: ```DESeq2 R package```

### 4. Protein Mutations in Deregulated Genes:

Map the identified genetic variations in case vs control to corresponding genes.
Focus on genes that are differentially expressed and identify mutations that may impact the protein-coding sequences.

- Tool: ```bash```

### 5. Identification of mutations with impact on protein structure

Utilize the AlphaMissense portal to predict the pathogenicity of selected mutations.
Interpret the results and categorize mutations based on their potential impact on protein structure and function.

- Tool: ```Alphamissense portal```

### Submission Requirements:

Submit a comprehensive report detailing each step of the analysis, including data processing, variant calling, identification of differentially expressed genes, and the selection of protein mutations. Include visualizations to support findings. Discuss the potential biological significance of identified mutations, particularly those predicted to be pathogenic.



