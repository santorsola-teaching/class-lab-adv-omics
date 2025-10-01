nextflow run nf-core/sarek -r 3.5.1 \
-c nextflow.config \
-profile test,gls \
--outdir 'gs://<YOUR_BUCKET_NAME>/results' \
-work-dir 'gs://<YOUR_BUCKET_NAME>/work'



# To copy files from your bucket to you cloud shell
# gsutil cp gs://path/to/your/bucket/dir .

 
