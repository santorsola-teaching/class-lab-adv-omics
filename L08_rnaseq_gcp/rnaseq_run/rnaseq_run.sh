screen

nextflow run nf-core/rnaseq -r 3.16.1 \
--input  datasets_LABOS_exercise1/rnaseq/reads/rnaseq_samplesheet.csv \
--outdir gs://'outdir-in-your-bucket' \
-work-dir gs://'workdir-in-your-bucket' \
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

