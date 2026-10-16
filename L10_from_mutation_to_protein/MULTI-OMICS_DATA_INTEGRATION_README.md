# Integrated omics analysis: from mutations to functional impact

This assignment explores the integration of DNA resequencing and RNAseq data to discover candidate disease-causing variants. 

By combining variant calling, transcript quantification, differential expression analysis, and protein structure impact predictions, you will identify pathogenic mutations occurring within perturbed transcriptional pathways.

## Tasks and Guidelines

### 1. Variant calling, annotation, and prioritisation 

Use nf-core/sarek to perform joint germline variant calling on case and control samples (e.g., via GATK haplotypecaller) and annotate variants (e.g., via SnpEff / Ensembl VEP).
After calling and annotation, establish a filtering and a prioritization scheme to get high-confidence, clinically relevant mutations.

#### Filtering Strategy: Define genotype criteria to isolate case-specific variants relative to control background. Filter by Ensembl impact (e.g., ```HIGH``` / ```MODERATE```) and sequence consequence (e.g., missense, loss-of-function, etc.).

#### Prioritization Framework

Population allele frequency (AF): Rank variants from ultra-rare to common.
In silico pathogenicity predictions: Evaluate functional impact using individual tools (e.g., SIFT, PolyPhen-2, AlphaMissense) or a **combined consensus** strategy to rank variants by predicted pathogenicity (e.g. deleterious -> benign).

### 2. Transcript quantification

Use nf-core/rnaseq with Salmon pseudo-alignment to estimate transcript abundances and raw gene read counts across case and control samples.

### 3. Differential expression analysis
Employ DESeq2 in R to identify differentially expressed genes (DEGs) between case and control conditions. 

### 4. Multi-omics integration
Integrate DNA resequencing outputs with RNAseq results to answer the questions: 
- How many genes are both differentially expressed (DEGs) and mutated in cases vs. controls?
- What types of mutations (e.g., missense, nonsense, splice site, synonymous) are present in DEGs compared to non-deregulated genes?
- How are variant severity classes distributed between up-regulated and down-regulated genes?
- Which prioritised pathogenic mutations map directly to significantly deregulated genes in the case sample?

### 5. Predicting mutation impact on protein structure & function
For the pathogenic candidate variants identified within deregulated genes: 
- What is the predicted impact of the candidate mutation on the protein structure?

Final report requirements

Submit a comprehensive report documenting your complete pipeline execution, methodologies, and findings. 

Your report should include:
- Methods & decision criteria: Clear justification of all filtering and prioritising criteria.

Data tables & visualisations: Summary tables detailing filtered variant callsets, top DEGs, cross-omics gene intersections, and pathogenicity prediction scores.

Biological Discussion: Highlight the top ranked candidate pathogenic mutations mapped to deregulated genes. Discuss their functional consequences on protein structure and their biological relevance to the underlying simulated disease phenotype.


