# From mutations to proteins

Explore omics datasets, including whole-genome re-sequencing and RNA-seq data, by running the nf-core/sarek and nf-core/rnaseq pipelines to perform variant calling and transcript quantification, respectively.

Analyze the potential impact of identified mutations on protein structure and function using the AlphaMissense resource.


## Datasets:

- Re-sequencing and RNAseq: ```https://github.com/santorsola-teaching/datasets_LABOS_exercise1/tree/main```
- References: ```https://github.com/lescai-teaching/datasets_reference_only.git```


## Tasks:

### 1. Variant calling and annotation

Use nf-core/sarek to:
- perform  joint variant calling on case and control samples, by haplotypecaller 
- annotate variants by snpeff. 

Then, select the most relevant mutations in the case sample versus control.

- Tools: ```nf-core/sarek, R, VEP, Alphamissense```


### 2. Quantification of transcript expression

Use nf-core/rnaseq to estimate read counts via salmon pseudo-alignment.


- Tool: ```nf-core/rnaseq```


### 3. Identification of Differentially Expressed Genes

Employ DESeq2 to identify genes with significant differential expression in cases versus controls.

- Tools: ```DESeq2 R package```


### 4. Protein Mutations in Deregulated Genes


Focus on differentially expressed genes and identify mutations that may impact the protein-coding sequences.

- Tool: ```R code```


### 5. Predicting mutation impact on protein structure

Use the AlphaMissense portal or VEP to predict the pathogenicity of selected mutations.
Interpret the results and categorize mutations based on their potential impact on protein structure and function.

- Tool: ```Alphamissense portal, VEP```

### Reporting:

Create a comprehensive report detailing each step of the analysis, including data processing, variant calling, identification of differentially expressed genes, and downstream analyses. 
Include visualizations to support findings. 
Discuss the potential biological significance of identified mutations, particularly those predicted to be pathogenic.


#### Inputs

Expression data:
- quant.sf files from nf-core/rnaseq (salmon.zip)

- transcript to gene IDs (gencode.v29.transcripts_no-vers_chr21_tx2gene.txt)

Variants:
- vcf file (joint_germline_recalibrated_snpEff.ann.vcf.gz)
    
External code 
- extract_annotations_full.R



#### External resources

- [VEP](https://www.ensembl.org/Tools/VEP)
- [ClinVar](https://www.ncbi.nlm.nih.gov/clinvar/)
- [Alphamissense](https://alphamissense.hegelab.org/)
- [gnomAD](https://gnomad.broadinstitute.org/)


