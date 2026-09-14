# nf-core/sarek - joint variant calling



## Set your working place

- Create your nextflow VM instance 


## Download the reference data

On your VM terminal, type:

```{bash}
git clone https://github.com/msantorsola/datasets_reference_only.git
```

to download the customised human reference files.



## Download the resequencing data

```{bash}
git clone https://github.com/santorsola-teaching/datasets_LABOS_exercise1.git
```



### Check the INPUT samplesheet 

File available in ```datasets_LABOS_exercise1/germline/reads/sarek_samplesheet.csv```.

```
patient,sample,lane,fastq_1,fastq_2
control,control1,lane1,datasets_LABOS_exercise1/germline/reads/normal_1.000+disease_0.000_1.fq.gz,datasets_LABOS_exercise1/germline/reads/normal_1.000+disease_0.000_2.fq.gz
case,case1,lane1,datasets_LABOS_exercise1/germline/reads/normal_0.000+disease_1.000_1.fq.gz,datasets_LABOS_exercise1/germline/reads/normal_0.000+disease_1.000_2.fq.gz

```

Remember: Each sample should be listed in a single row of the input samplesheet.



## Prepare your config file


For detailed instructions on the Nextflow config file to run Sarek, see [here](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L04_resequencing_sarek_gcp/sarek_run/sarek_nextflow.config).

Required Information:
- google.project = 'YOUR-PROJECT-NAME'

Make sure to replace 'YOUR-PROJECT-NAME' with the appropriate project name for your setup.


_When using vim to edit files on terminal, Make sure to click "i" for INSERT mode, before to paste the code_



## Launch nf-core/sarek: joint variant calling

For detailed command-line instructions to run Sarek, refer to see [here](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L04_resequencing_sarek_gcp/sarek_run/sarek_run.sh)


Required Replacements:
- Replace --outdir 'outdir-in-your-bucket' with the path to your desired output directory in your GCP bucket.
- Replace -work-dir 'workdir-in-your-bucket' with the path to your working directory in your GCP bucket.

Make sure to adjust these paths according to your project setup before running the command.



