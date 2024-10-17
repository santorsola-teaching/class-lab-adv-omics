nextflow run nf-core/sarek -r 3.4.4 \
--input datasets_LABOS_exercise1/germline/reads/sarek_samplesheet.csv \
--outdir 'outdir' \
-work-dir 'workdir' \
--igenomes_ignore true \
--genome GRCh38chr21 \
--tools haplotypecaller,snpeff \
--skip_tools haplotypecaller_filter \
--joint_germline \
--intervals datasets_LABOS_exercise1/germline/chr21_intervals.list \
-c sarek_nextflow.config \
--aligner bwa-mem2

