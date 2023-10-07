nextflow run nf-core/sarek -r 3.2.1 \
-c google.config  \
-profile test,gls \
--outdir gs://unipv-bioinf-student-msantorsola-data-main/results \
-work-dir gs://unipv-bioinf-student-msantorsola-data-main/results/work

