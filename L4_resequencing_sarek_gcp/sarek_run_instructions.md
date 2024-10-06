# nf-core/sarek - resequencing data analysis

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

On VM SSH terminal type:

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

See [here]() for instructions related to the nextflow config file to run sarek.


Required information:

- your projectID = mbg-bioinf-student-<surname>


_When using vim to edit files on terminal, Make sure to click "i" for INSERT mode, before to paste the code_


## Launch nf-core/sarek: joint variant calling
```

See the command line to run the sarek [here]()



### Check results


In the ```results``` directory in your bucket, you should see now:
- a single VCF file from joint variant calling

To copy you VCF files, you can type on your cloud shell:
```
gsutil cp gs://results-in-your-bucket/annotation/haplotypecaller/joint_variant_calling/joint_germline_recalibrated_snpEff.ann.vcf.gz .

or


gsutil cp gs://results-in-your-bucket/annotation/haplotypecaller/sample_01/sample_01.haplotypecaller_snpEff.ann.vcf.gz .

gsutil cp gs://results-in-your-bucket/annotation/haplotypecaller/sample_02/sample_02.haplotypecaller_snpEff.ann.vcf.gz .
```     


## Check the running workflow

Find the session ID list of the current running screen sessions with:

```
screen -ls
```

You can re-attach the terminal session with:
```
screen -r
```

In case you have multiple screen sessions running on your VM instance, you will need to append the screen session ID after "-r".


To detach the terminal session type:
“Ctrl-A” and “d“

To show the screen parameters, you can type:
“Ctrl-A” and “?” without quotes.


To terminate a screen window session
“ctrl-a” and “k” without quotes






