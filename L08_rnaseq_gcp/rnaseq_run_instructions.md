# nf-core/rnaseq - read quantification



## Set your working place

- Create your VM instance from Google Cloud Console.

Follow instructions in this [video](https://drive.google.com/file/d/1WQ3LYle15dkxdSXwZJTjM8sgmRDghkcg/view)

- Install the required tools on your VM instance

Follow instructions [here](https://github.com/santorsola-teaching/class-lab-adv-omics/tree/main/L03_google_cloud_nextflow_setup/gcp_setup_master_vm)



## Upload your nextflow credentials key

After the VM is spun up, open the VM terminal via SSH and upload your Nextflow credentials key (.json), and then type:

```{bash}
export GOOGLE_APPLICATION_CREDENTIALS=/home/YOUR_HOME_FOLDER/NAME-OF-YOUR-KEY.json
```

Upload may take several attempts, e.g. caused by SSH authentication failure. When the upload is successful, the message *"Transferred 1 item"* appears on the VM SSH terminal.

To check your key path, type:

```
echo $GOOGLE_APPLICATION_CREDENTIALS
```



## Download the reference data

On your VM SSH terminal, type:

```{bash}
git clone https://github.com/lescai-teaching/datasets_reference_only.git
```

to download the customized Human reference files related to chromosome 21.



## Download the resequencing data

```{bash}
git clone https://github.com/santorsola-teaching/datasets_LABOS_exercise1.git
```



### Check the INPUT samplesheet 

File available in ```datasets_LABOS_exercise1/rnaseq/reads/rnaseq_samplesheet.csv```.

```
sample,fastq_1,fastq_2,strandedness
control_rep1,datasets_LABOS_exercise1/rnaseq/reads/sample_01_1.fastq.gz,datasets_LABOS_exercise1/rnaseq/reads/sample_01_2.fastq.gz,unstranded
control_rep2,datasets_LABOS_exercise1/rnaseq/reads/sample_02_1.fastq.gz,datasets_LABOS_exercise1/rnaseq/reads/sample_02_2.fastq.gz,unstranded
control_rep3,datasets_LABOS_exercise1/rnaseq/reads/sample_03_1.fastq.gz,datasets_LABOS_exercise1/rnaseq/reads/sample_03_2.fastq.gz,unstranded
treatment_rep1,datasets_LABOS_exercise1/rnaseq/reads/sample_04_1.fastq.gz,datasets_LABOS_exercise1/rnaseq/reads/sample_04_2.fastq.gz,unstranded
treatment_rep2,datasets_LABOS_exercise1/rnaseq/reads/sample_05_1.fastq.gz,datasets_LABOS_exercise1/rnaseq/reads/sample_05_2.fastq.gz,unstranded
treatment_rep3,datasets_LABOS_exercise1/rnaseq/reads/sample_06_1.fastq.gz,datasets_LABOS_exercise1/rnaseq/reads/sample_06_2.fastq.gz,unstranded

```

Remember: Each sample should be listed in a single row of the input samplesheet.



## Prepare your config file


For detailed instructions on the Nextflow config file to run rnaseq, see [here](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L08_rnaseq_gcp/rnaseq_run/rnaseq_nextflow.config).

Required Information:
- google.project = 'YOUR-PROJECT-NAME'

Make sure to replace 'YOUR-PROJECT-NAME' with the appropriate project name for your setup.



## Launch nf-core/rnaseq: read quantification

For detailed command-line instructions to run rnaseq, refer to see [here](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L08_rnaseq_gcp/rnaseq_run/rnaseq_run.sh)


Required Replacements:
- Replace --outdir 'outdir-in-your-bucket' with the path to your desired output directory in your GCP bucket.
- Replace -work-dir 'workdir-in-your-bucket' with the path to your working directory in your GCP bucket.

Make sure to adjust these paths according to your project setup before running the command.




