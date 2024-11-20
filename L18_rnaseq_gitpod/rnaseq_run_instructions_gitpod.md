# nf-core/rnaseq - read quantification



## Launch Gitpod


To use GitPod, please make sure:

1. You have a GitHub account: if not, create one [here](https://github.com/signup)
2. Once you have a GitHub account, sign up for GitPod using your GitHub user [here](https://gitpod.io/login/) choosing "continue with GitHub".

Now you're all set and can use the following button to launch the service:


[![Open in GitPod](https://img.shields.io/badge/Gitpod-%20Open%20in%20Gitpod-908a85?logo=gitpod)](https://gitpod.io/#https://github.com/santorsola-teaching/nf-core-gitpod-run)



## Download the reference data

On your Gitpod terminal, type:

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

Note:
Each sample should be listed in a single row of the input samplesheet.



## Prepare your config file


For detailed instructions on configuring the Nextflow config file to run rnaseq, refer to [here](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L18_rnaseq_gitpod/rnaseq_run_gitpod/rnaseq_nextflow.config).


Ensure your config includes the following lines:

```
docker.enabled = true
docker.runOptions = '-u $(id -u):$(id -g)'
```

These settings enable Docker and mount the container with all the necessary tools for running the nf-core pipeline and downstream analyses.


## Launch nf-core/rnaseq: read quantification

For detailed command-line instructions to run rnaseq, refer to [here](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L18_rnaseq_gitpod/rnaseq_run_gitpod/rnaseq_run.sh)


**Note:** We are using version `r 3.12.0` for compatibility with the Gitpod container. This will not affect your results.


Required Replacements:
- Replace ```--outdir 'outdir'``` with the path to your desired output directory in the gitpod home (```/workspace/gitpod/workfolder```).
- Replace ```-work-dir 'workdir'``` with the path to your working directory in the gitpod home (```/workspace/gitpod/workfolder```).


To download the *salmon* directory, right-click on it, choose **Download**, and then compress the directory into a file named `salmon.zip`.

Alternatively, you can compress the directory directly in the Gitpod environment by entering the following command in the terminal:

```
zip -r salmon.zip /PATH/TO/salmon
```

Once the directory is compressed into a ZIP file, you can upload it to the RStudio environment.


# Downstream analyses

## Launching the RStudio environment

Once the nf-core pipeline run is terminated, you need to launch the RStudio server:

```bash
sudo rstudio-server start
```

A pop-up will appear and by clicking on **Open**, we will be redirected to the RStudio login page. By inserting the username and the password reported below, you will be able to connect to RStudio:

```bash
Username: gitpod
Password: pass
```

To prevent losing connection, go back to gitpod and type on the **Terminal**:

```bash
sleep 2h
```

This command will keep the gitpod session active for exactly 2 hours, providing sufficient time to complete our analysis without interruption.



## Reporting 

You can use the Rmd code template available [here](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L17_rnaseq_DEA_reporting/reporting_template/report_DEA_gcp.Rmd) to get the HTML final report. 


**Note**: the additional file to carry out the analyses is available [here](https://github.com/lescai-teaching/datasets_reference_only/blob/main/trascriptome/gencode.v29.transcripts_no-vers_chr21_tx2gene.txt).


Note: When opening the Rmd document with the report template, you may be prompted to install certain packages required by the code. If prompted, proceed with the installation as needed.


## Knitting to HTML
When knitting to HTML, you might be prompted to install a new version of the markdown package. Please proceed with the installation.



## Closing the Workspace

After completing your analysis, you can close the Gitpod and RStudio windows in your browser.

Additionally, to **save credits**, you should **delete your workspace**. To do this:

1. Go to [Gitpod](https://gitpod.io/).
2. You will be redirected to your [workspaces](https://gitpod.io/workspaces).
3. Click on the three dots next to the workspace you want to delete.
4. Select **Delete** (in red).










