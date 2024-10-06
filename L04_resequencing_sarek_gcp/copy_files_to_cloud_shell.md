### Check results


In the output directory of your GCP bucket, you should now see:

- a single VCF file from joint variant calling


To read your VCF file without downloading it, copy it to your *Cloud Shell* by typing:


```
gsutil cp gs://results-in-your-bucket/annotation/haplotypecaller/joint_variant_calling/joint_germline_recalibrated_snpEff.ann.vcf.gz .

```

