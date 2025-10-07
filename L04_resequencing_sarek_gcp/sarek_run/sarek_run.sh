


nextflow run nf-core/sarek -r 3.4.4 \
--input datasets_LABOS_exercise1/germline/reads/sarek_samplesheet.csv \
--outdir 'outdir-in-your-bucket' \
-work-dir 'workdir-in-your-bucket' \
--igenomes_ignore true \
--genome GRCh38chr21 \
--tools haplotypecaller,snpeff \
--skip_tools haplotypecaller_filter \
--joint_germline \
--intervals datasets_LABOS_exercise1/germline/chr21_intervals.list \
-c sarek_nextflow.config \
-profile gls \
--aligner bwa-mem2


### To detach the terminal session type: “Ctrl-a-d“

### path to directories in GCP bucket are indicated as 'gs://unipv-bioinf-student-YOURNAME-data-main/NAME-OF-DIR'


