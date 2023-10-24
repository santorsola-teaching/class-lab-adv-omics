# nf-core/sarek - mapping

## Set your working place

Create your VM instance from Google Cloud Console.
To check you are working within the COURSE project, open cloud shell and type:

```{bash}
gcloud config set project ${PROJECT_ID}
```

Install the required tools on you VM instance

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

export PATH=${PATH}:${PWD}
```

### Upload your nextflow credentials key

```{bash}
export GOOGLE_APPLICATION_CREDENTIALS=/home/YOUR_HOME_FOLDER/NAME-OF-YOUR-KEY.json
```

## Download the datasets and the reference data

```{bash}
git clone https://github.com/lescai-teaching/datasets_bsa-2022.git
git clone https://github.com/lescai-teaching/datasets_reference_only.git
```

## Prepare the INPUT samplesheet ```sarek_samplesheet.csv```

```

#rename fastq files
for i in $(ls *.gz); do mv -- "$i" "${i%.fq.gz}.fastq.gz"; done

#sarek_samplesheet.csv
patient,sample,lane,fastq_1,fastq_2
patient_01,sample_01,datasets_bsa-2022/rna_sequencing/raw_data/sample_01_1.fastq.gz,datasets_bsa-2022/rna_sequencing/raw_data/sample_01_2.fastq.gz,auto
patient_02,sample_02,datasets_bsa-2022/rna_sequencing/raw_data/sample_02_1.fastq.gz,datasets_bsa-2022/rna_sequencing/raw_data/sample_02_2.fastq.gz,auto
```


## Prepare your config

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
```

## Prepare your params-file
```#-params-file sarek-params-file.json
{{
    "input": "sarek_samplesheet.csv.csv",
    "outdir": "gs:\/\/unipv-bioinf-student-msantorsola-data-main\/results",
    "split_fastq": "0",
    "no_intervals": true,
    "tools": "haplotypecaller",
    "bwa": "datasets_reference_only\/sequence\/Homo_sapiens_assembly38_chr21.fasta.{amb,ann,bwt,pac,sa}",
    "dbsnp": "datasets_reference_only\/gatkbundle\/dbsnp_146.hg38_chr21.vcf.gz",
    "dbsnp_tbi": "datasets_reference_only\/gatkbundle\/dbsnp_146.hg38_chr21.vcf.gz.tbi",
    "dict": "datasets_reference_only\/sequence\/Homo_sapiens_assembly38_chr21.dict",
    "fasta": "datasets_reference_only\/sequence\/Homo_sapiens_assembly38_chr21.fasta",
    "fasta_fai": "datasets_reference_only\/sequence\/Homo_sapiens_assembly38_chr21.fasta.fai",
    "known_indels": "datasets_reference_only\/gatkbundle\/Mills_and_1000G_gold_standard.indels.hg38_chr21.vcf.gz ",
    "known_indels_tbi": "gatkbundle\/Mills_and_1000G_gold_standard.indels.hg38_chr21.vcf.gz.tbi",
    "igenomes_ignore": true,
    "max_cpus": 4,
    "max_memory": "60.GB",
    "max_time": "4.h"
}
```

## Launch nf-core/sarek

```{bash}
screen #

nextflow run nf-core/sarek -r 3.3.2 \
 -profile google.config \
 -work-dir gs://your_bucket/work \
 -params-file sarek-params-file.json
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


To detach the terminal session type
“Ctrl-A” and “d“

To show the screen parameters, you can type
“Ctrl-A” and “?” without quotes.


To terminate a screen window session
“ctrl-a” and “k” without quotes


