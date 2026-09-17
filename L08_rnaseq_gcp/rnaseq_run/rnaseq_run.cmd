## Command lines to run nf-core/rnaseq must be executed in the VM terminal 

screen

nextflow run nf-core/rnaseq -r 3.16.1 \
--input  PATH/TO/rnaseq/reads/rnaseq_samplesheet.csv \
--outdir gs://unipv-bioinf-student-YOURNAME-data-main/rnaseq_results_dir_DATASET \
-work-dir gs://unipv-bioinf-student-YOURNAME-data-main/rnaseq_work_dir_DATASET \
--genome GRCh38chr21 \
--pseudo_aligner salmon \
--skip_alignment \
--skip_biotype_qc \
-c rnaseq_nextflow.config \
-profile gls \
--skip_stringtie \
--skip_bigwig \
--skip_umi_extract \
--skip_trimming \
--skip_fastqc

