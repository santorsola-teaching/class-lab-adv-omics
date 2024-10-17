# nf-core/sarek - joint variant calling



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



