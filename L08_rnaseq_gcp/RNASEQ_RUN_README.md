# nf-core/rnaseq - read quantification

## Launch the working VM from the image
Spin up your pre-configured Nextflow working environment directly from your custom image.

Command:
```{bash}
sh 03_launch_nextflow_from_image.sh
```

Connect to your VM via SSH:
```{bash}
gcloud compute ssh nextflow-work-vm --zone=europe-west1-b
```

Your shell will automatically log into the VM and the prompt will change to ```username@nextflow-master:~$```



## Download your group dataset & enter the working directory
Each group will work on a specific resequencing dataset assigned by the instructor.

Check your assigned group number and download your datasets using ```git clone``` with your assigned group number, then navigate into that directory immediately:

Example for group 1:

```{bash}
git clone https://github.com/santorsola-teaching/datasets_group1.git
```


Move inside your group directory:
```{bash}
cd datasets_group1
```

Verify your current directory structure by listing the files:
```{bash}
ls
```

> Important: All subsequent steps (downloading references, editing configs, running Sarek) must be executed from inside this directory (e.g., datasets_group1).

## Download the reference data

On your VM terminal, type:

```{bash}
git clone https://github.com/msantorsola/datasets_reference_only.git
```

to download the customised human reference files.


### Check the INPUT samplesheet 

File available in ```PATH/TO/rnaseq/reads/rnaseq_samplesheet.csv```.

```
patient,sample,lane,fastq_1,fastq_2
control,control1,lane1,PATH/TO/germline/reads/normal_1.000+disease_0.000_1.fq.gz,datasets_LABOS_exercise1/germline/reads/normal_1.000+disease_0.000_2.fq.gz
case,case1,lane1,PATH/TO/germline/reads/normal_0.000+disease_1.000_1.fq.gz,datasets_LABOS_exercise1/germline/reads/normal_0.000+disease_1.000_2.fq.gz

```

Remember: Each sample should be listed in a single row of the input samplesheet.



## Prepare your config file


For detailed instructions on the Nextflow config file to run rnaseq, see [here](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L08_rnaseq_gcp/rnaseq_run/rnaseq_nextflow.config).

Required Information:
- ```google.project = 'YOUR-PROJECT-NAME'```

Make sure to replace ```'YOUR-PROJECT-NAME'``` with the appropriate project name for your setup.


When using ```vim``` to edit files on terminal, make sure to click ```i``` for INSERT mode, before to paste the code.



## Launch nf-core/rnaseq: read quantification

For detailed command-line instructions to run rnaseq, see  [here](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L08_rnaseq_gcp/rnaseq_run/rnaseq_run.cmd)


Required Replacements:
- ```--outdir gs://unipv-bioinf-student-YOURNAME-data-main/rnaseq_results_dir_DATASET```
- ```-work-dir gs://unipv-bioinf-student-YOURNAME-data-main/rnaseq_work_dir_DATASET```

Make sure to adjust these paths according to your project setup before running the command.


# Verify and inspect rnaseq results

Once the Nextflow pipeline execution completes, all generated outputs will be stored in your assigned Google Cloud Storage (GCS) bucket.

## 1. Output directory structure

Your results directory contains the following main subfolders:

- `multiqc/`
- `pipeline_info/`
- `salmon/`

The primary quantification results and count matrices are located inside the `salmon/` directory:

- Sample quantification subdirectories: 
	- `control_rep1/`
		- `aux_info/`
		- `cmd_info.json`
		- `libParams/`
		- `lib_format_counts.json`
		- `logs/`
		- `quant.genes.sf`
		- `quant.sf`
	- `control_rep2/`
	- `control_rep3/`
	- `treatment_rep1/`
	- `treatment_rep2/`
	- `treatment_rep3/`
- Exploratory & quality control output: `deseq2_qc/`
- Key output matrices and objects:
  - `salmon.merged.gene_counts.tsv` & `salmon.merged.gene_counts.SummarizedExperiment.rds`
  - `salmon.merged.gene_counts_length_scaled.tsv` & `.rds`
  - `salmon.merged.gene_counts_scaled.tsv` & `.rds`
  - `salmon.merged.gene_tpm.tsv`
  - `salmon.merged.gene_lengths.tsv`
  - `salmon.merged.transcript_counts.tsv` & `.rds`
  - `salmon.merged.transcript_tpm.tsv`
  - `salmon.merged.transcript_lengths.tsv`
  - `tx2gene.tsv`


To inspect the matrix of transcript read counts directly inside the terminal of your VM or Google Cloud Shell, copy it to your current directory:

```
gsutil cp gs://unipv-bioinf-student-YOURNAME-data-main/rnaseq_results_dir_g1_1/salmon/control_rep1/quant.sf .

```


> ```
> Name            Length  EffectiveLength TPM     NumReads
> ENST00000624081 513     262.924 1295.330019     297.211
> ENST00000612610 1162    911.923 364.340105      289.948
> ENST00000620481 816     565.923 947.732436      468.056
> ENST00000623960 3274    3023.923        555.359898      1465.547
> ENST00000623903 998     747.923 544.097721      355.131
> ENST00000623795 2238    1987.923        501.013206      869.167
> ENST00000624810 411     160.924 794.570121      111.585
> ENST00000625036 318     68.167  1466.916238     87.263
```

> Key Columns Description:
> - `Name`: Ensembl transcript ID.
> - `Length`: Sequence length of the transcript in base pairs.
> - `EffectiveLength`: Computed effective length taking into account fragment length distribution and sequence bias.
> - `TPM`: Transcripts Per Million (normalised measure of transcript abundance).
> - `NumReads`: Estimated number of reads originating from this transcript (raw read counts used as input for DESeq2/tximport).


