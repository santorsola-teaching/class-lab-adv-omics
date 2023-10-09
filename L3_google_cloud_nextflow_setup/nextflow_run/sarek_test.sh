nextflow run nf-core/sarek -r 3.2.1 \
-c google.config  \
-profile test,gls \
--outdir resultdir-in-your-bucket \
-work-dir workdir-in-your-bucket

