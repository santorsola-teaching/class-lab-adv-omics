# Class Assignment: run nf-core/sarek with -params-file option
## Solutions


## Your json params-file
```
{
    "input": "datasets_LABOS-2023\/germline\/reads\/sarek_samplesheet.csv",
    "outdir": " gs://results-in-your-bucket",
    "tools": "haplotypecaller,snpeff",
    "skip_tools": "haplotypecaller_filter",
    "joint_germline": true,
    "use_annotation_cache_keys": true,
    "genome": "GRCh38chr21",
    "bwa": "\/home\/YOUR_HOME_FOLDER\/datasets_LABOS-2023\/refs\/sequence\/Homo_sapiens_assembly38_chr21.fasta.{amb,ann,bwt,pac,sa}",
    "dbsnp": "\/home\/YOUR_HOME_FOLDER\/datasets_LABOS-2023\/refs\/annotations\/dbsnp_146.hg38_chr21.vcf.gz",
    "dbsnp_tbi": "\/home\/YOUR_HOME_FOLDER\/datasets_LABOS-2023\/refs\/annotations\/dbsnp_146.hg38_chr21.vcf.gz.tbi",
    "dbsnp_vqsr": "--resource:dbsnp,known=false,training=true,truth=false,prior=2.0 dbsnp_146.hg38_chr21.vcf.gz",
    "dict": "\/home\/YOUR_HOME_FOLDER\/datasets_LABOS-2023\/refs\/sequence\/Homo_sapiens_assembly38_chr21.dict",
    "fasta": "\/home\/YOUR_HOME_FOLDER\/datasets_LABOS-2023\/refs\/sequence\/Homo_sapiens_assembly38_chr21.fasta",
    "fasta_fai": "\/home\/YOUR_HOME_FOLDER\/datasets_LABOS-2023\/refs\/sequence\/Homo_sapiens_assembly38_chr21.fasta.fai",
    "germline_resource": "\/home\/YOUR_HOME_FOLDER\/datasets_LABOS-2023\/refs\/annotations\/gnomAD.r2.1.1.GRCh38.PASS.AC.AF.only_chr21.vcf.gz",
    "germline_resource_tbi": "\/home\/YOUR_HOME_FOLDER\/datasets_LABOS-2023\/refs\/annotations\/gnomAD.r2.1.1.GRCh38.PASS.AC.AF.only_chr21.vcf.gz.tbi",
    "known_indels": "\/home\/YOUR_HOME_FOLDER\/datasets_LABOS-2023\/refs\/annotations\/Mills_and_1000G_gold_standard.indels.hg38_chr21.vcf.gz",
    "known_indels_tbi": "\/home\/YOUR_HOME_FOLDER\/datasets_LABOS-2023\/refs\/annotations\/Mills_and_1000G_gold_standard.indels.hg38_chr21.vcf.gz.tbi",
    "known_indels_vqsr": "--resource:mills,known=false,training=true,truth=true,prior=10.0 Mills_and_1000G_gold_standard.indels.hg38_chr21.vcf.gz",
    "known_snps": "\/home\/YOUR_HOME_FOLDER\/datasets_LABOS-2023\/refs\/annotations\/1000G_phase1.snps.high_confidence.hg38_chr21.vcf.gz",
    "known_snps_tbi": "\/home\/YOUR_HOME_FOLDER\/datasets_LABOS-2023\/refs\/annotations\/1000G_phase1.snps.high_confidence.hg38_chr21.vcf.gz.tbi",
    "known_snps_vqsr": "--resource:1000G,known=false,training=true,truth=true,prior=10.0 1000G_phase1.snps.high_confidence.hg38_chr21.vcf.gz",
    "snpeff_db": "105",
    "snpeff_genome": "GRCh38",
   "igenomes_base": "\/home\/YOUR_HOME_FOLDER\/datasets_LABOS-2023\/refs",
    "igenomes_ignore": true,
    "intervals": "\/home\/YOUR_HOME_FOLDER\/datasets_LABOS-2023\/germline\/chr21_intervals.list"
}
```

#### Your Command Line for nf-core/sarek joint germline calling

```
nextflow run nf-core/sarek -r 3.3.2 \
-params-file sarek_joint_calling_params-file.json \
-c nextflow_with_params-file.config \
-profile  gls


