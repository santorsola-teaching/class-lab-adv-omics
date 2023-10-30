# Class Assignment: run nf-core/sarek _joint germline calling_ with -params-file option

## Objective
The primary goal of this assignment is to gain practical experience in using the nf-core/sarek pipeline by analyzing parameter configurations and executing the pipeline. This assignment will help students understand how to set up nf-core/sarek for genomic analysis and appreciate the significance of parameter configurations.

## Assignment Description

Your task is to explore the configuration options of the nf-core/sarek pipeline, analyze the parameters used in your previous sarek runs, and ultimately execute the pipeline with the ```-params-file``` option.


## Set your working place

- Create your VM instance from Google Cloud Console.

- Install the required tools on your VM instance


```{bash}
sudo yum install -y git
sudo yum install -y java-11-openjdk-devel
sudo yum install -y screen

#export nextflow
export NXF_VER=23.04.3
export NXF_MODE=google

#download & install nextflow
mkdir nfbin
cd nfbin
curl https://get.nextflow.io | bash
cd ..

export PATH=${PATH}:${PWD} #to nfbin dir
```

Check the nextflow installation:

```
nextflow -version
```


## Upload your nextflow credentials key

```{bash}
export GOOGLE_APPLICATION_CREDENTIALS=/home/YOUR_HOME_FOLDER/NAME-OF-YOUR-KEY.json
```

Upload may take several attempts, e.g. caused by SSH authentication failure. When the upload is successful, the message *"Transferred 1 item"* appears on the VM SSH terminal. 

To check your key path:

```
echo $GOOGLE_APPLICATION_CREDENTIALS
```


## Download the datasets and the reference data

```{bash}
git clone https://github.com/santorsola-teaching/datasets_LABOS-2023.git
```


### Prepare the INPUT samplesheet 

The file is available in ```datasets_LABOS-2023/germline/reads/sarek_samplesheet.csv```.

```
patient,sample,lane,fastq_1,fastq_2
patient_01,sample_01,lane1,datasets_LABOS-2023/germline/reads/case_1.fastq.gz,datasets_LABOS-2023/germline/reads/case_2.fastq.gz
patient_02,sample_02,lane1,datasets_LABOS-2023/germline/reads/control_1.fastq.gz,datasets_LABOS-2023/germline/reads/control_2.fastq.gz
```


## Prepare your config file


``` 
vi nextflow_with_params-file.config
```

Required information:

- your projectID = mbg-bioinf-student-<surname>
- your bucket name = unipv-bioinf-student-<surname>-data-main


Remember to configure the following parameters with your personal credentials:
- workDir
- google.project


Here's a bit of guidance to assist you with your configuration file


``` 
profiles {
    gls {
        process.executor = 'google-batch'
        workDir = 'workdir-in-your-bucket'
        google.location = 'europe-west4'
        google.region  = 'europe-west4'
        google.project = 'YOUR-PROJECT-NAME'
        google.lifeSciences.usePrivateAddress = 'true'
        google.batch.spot = true
        fusion.enabled = true
        wave.enabled = true
        process.scratch = false
    }
}


process {
  errorStrategy = { task.exitStatus in [1,143,137,104,134,139,255,108] ? 'retry' : 'finish' }
  maxRetries = 4
  maxErrors = '-1'

}

params {
    max_cpus   = 2
    max_memory = '6.5GB'
    max_time   = '4.h'
    }

process {
    withName: 'VARIANTRECALIBRATOR_INDEL' {
        ext.prefix = { "${meta.id}_INDEL" }
        ext.args = "-an QD -an FS -an SOR -an DP  -mode INDEL"
        publishDir = [
            enabled: false
        ]
    }

    withName: 'VARIANTRECALIBRATOR_SNP' {
        ext.prefix = { "${meta.id}_SNP" }
        ext.args = "-an QD -an MQ -an FS -an SOR -mode SNP"
        publishDir = [
            enabled: false
        ]
    }
}
``` 

_Make sure to click "i" for INSERT mode in vi editor, before paste the code_


## Generate your params-file file

```
vi sarek_joint_calling_params-file.json
```


### Instructions

Review your old [command line](https://github.com/santorsola-teaching/class-lab-adv-omics-2023/blob/main/L12_resequencing_sarek_mapping/sarek_exercise.md#launch-nf-coresarek-single-sample-calling) and [config](https://github.com/santorsola-teaching/class-lab-adv-omics-2023/blob/main/L12_resequencing_sarek_mapping/sarek_exercise.md#prepare-your-config-file) file.

#### Identify Parameters Used 
Analyze the old command line and config file to identify the parameters that were used in your previous sarek run. Take note of the parameters that define the paths to references and external resource databases, as well as any other parameters that were crucial for your analysis.

#### Examine Matching Parameters in the Launch Web Page
Compare the parameters you identified in your old command line and config file with the options available in the [Launch](https://nf-co.re/launch) web interface. 

#### Generate a JSON Configuration File
Create a JSON configuration file that includes the parameters you intend to use for your sarek analysis. Make sure to specify the paths to references and external resources databases. 

```
{
    "input":
    
    [...]

}
```


#### Compose the Command Line for Sarek
Based on the parameters you've defined in the JSON configuration file, create the command line to execute sarek. 

Make sure to include the path to your 
- JSON file
- config file

and to provide the profile (_gls_) you are using.


```
nextflow run nf-core/sarek -r 3.3.2 \
-params-file [...] \
-c  [...] \
-profile [...]
```

#### Execute Sarek
Run the Sarek pipeline using the command line you composed in the previous step. Monitor the progress and make sure that the pipeline runs without errors.










