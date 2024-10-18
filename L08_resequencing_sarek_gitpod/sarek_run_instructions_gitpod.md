# nf-core/sarek - joint variant calling



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

File available in ```datasets_LABOS_exercise1/germline/reads/sarek_samplesheet.csv```.

```
patient,sample,lane,fastq_1,fastq_2
control,control1,lane1,datasets_LABOS_exercise1/germline/reads/normal_1.000+disease_0.000_1.fq.gz,datasets_LABOS_exercise1/germline/reads/normal_1.000+disease_0.000_2.fq.gz
case,case1,lane1,datasets_LABOS_exercise1/germline/reads/normal_0.000+disease_1.000_1.fq.gz,datasets_LABOS_exercise1/germline/reads/normal_0.000+disease_1.000_2.fq.gz

```

Note:
Each sample should be listed in a single row of the input samplesheet.



## Prepare your config file


For detailed instructions on configuring the Nextflow config file to run Sarek, refer to [here](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L08_resequencing_sarek_gitpod/sarek_run_gitpod/sarek_nextflow.config).

Note:
Ensure your config includes the following lines:

```
docker.enabled = true
docker.runOptions = '-u $(id -u):$(id -g)'
```

These settings enable Docker and mount the container with all the necessary tools for running the nf-core pipeline and downstream analyses.


## Launch nf-core/sarek: joint variant calling

For detailed command-line instructions to run Sarek, refer to [here](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L08_resequencing_sarek_gitpod/sarek_run_gitpod/sarek_run.sh)


Required Replacements:
- Replace ```--outdir 'outdir'``` with the path to your desired output directory in the gitpod home (```/workspace/gitpod/workfolder```).
- Replace ```-work-dir 'workdir'``` with the path to your working directory in the gitpod home (```/workspace/gitpod/workfolder```).


# Downstram analyses

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

You can use the Rmd code template available [here](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L05_reseq_prior_reporting/reporting_template/report_sarek_test_gcp.Rmd) to get the HTML final report. 


Note: the additional code to carry out the analyses is available [here](https://github.com/santorsola-teaching/class-lab-adv-omics/tree/main/L05_reseq_prior_reporting/code)


