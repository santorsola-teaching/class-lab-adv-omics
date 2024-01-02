nextflow run nf-core/sarek -r 3.2.1 \
-c google.config  \
-profile test,gls \
--outdir resultdir-in-your-bucket \
-work-dir workdir-in-your-bucket



#To copy files from your bucket to you cloud shell

gsutil cp gs://path/to/your/bucket/dir .

 
