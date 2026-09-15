## command lines to run sarek

screen


nextflow run nf-core/sarek -r 3.4.4 \
--input PATH/TO/germline/reads/sarek_samplesheet.csv \
--outdir gs://unipv-bioinf-student-YOURNAME-data-main/sarek_results_dir_DATASET \
-work-dir gs://unipv-bioinf-student-YOURNAME-data-main/sarek_work_dir_DATASET \
--igenomes_ignore true \
--genome GRCh38chr21 \
--tools haplotypecaller,snpeff \
--skip_tools haplotypecaller_filter \
--joint_germline \
--intervals PATH/TO/germline/chr21_intervals.list \
-c sarek_nextflow.config \
-profile gls \
--aligner bwa-mem2


