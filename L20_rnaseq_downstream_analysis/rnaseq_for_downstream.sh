# nf-core/rnaseq - dataset for downstream analyses

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

export PATH=${PATH}:${PWD}
```

Check the nextflow installation:

```
nextflow -version
```


## Upload your nextflow credentials key

```{bash}
export GOOGLE_APPLICATION_CREDENTIALS=/home/YOUR_HOME_FOLDER/NAME-OF-YOUR-KEY.json
```

Upload may take several attempts, e.g. caused by SSH authentication failure.  
When the upload is successful, the message *"Transferred 1 item"* appears on the VM SSH terminal.  
To check your key path type:

```
echo $GOOGLE_APPLICATION_CREDENTIALS
```


## Download the datasets and the reference data

### AGGIUNGERE NUOVO DATASET!!!!
```{bash}
git clone https://github.com/santorsola-teaching/datasets_LABOS-2023.git
```


### Prepare the INPUT samplesheet 

File available in ```datasets_LABOS-2023/rnaseq/reads/rnaseq_samplesheet.csv```.

```
sample,fastq_1,fastq_2,strandedness
control_rep1,data/reads/sample_01_1.fastq.gz,data/reads/sample_01_2.fastq.gz,auto
control_rep2,data/reads/sample_02_1.fastq.gz,data/reads/sample_02_2.fastq.gz,auto
control_rep3,data/reads/sample_03_1.fastq.gz,data/reads/sample_03_2.fastq.gz,auto
treatment_rep1,data/reads/sample_04_1.fastq.gz,data/reads/sample_04_2.fastq.gz,auto
treatment_rep2,data/reads/sample_05_1.fastq.gz,data/reads/sample_05_2.fastq.gz,auto
treatment_rep3,data/reads/sample_06_1.fastq.gz,data/reads/sample_06_2.fastq.gz,auto
```


## Prepare your config file

``` vi nextflow.config```

Required information:

- your projectID = mbg-bioinf-student-<surname>
- your bucket = unipv-bioinf-student-<surname>-data-main


Remember to configure the following parameters with your personal credentials:
- workDir
- google.project
- igenomes_base

``` 
profiles {
    gls {
        process.executor = 'google-batch'
        workDir = 'gs://mbg-bioinfomics-ms-data/work'
        google.location = 'europe-west4'
        google.region  = 'europe-west4'
        google.project = 'c510329-adv-bioinf-omics'
        google.lifeSciences.usePrivateAddress = 'true'
        fusion.enabled = true
        wave.enabled = true
        process.scratch = false
    }
}
process {
    withName: 'FQ_SUBSAMPLE' {
        ext.args   = '-p 0.7 --seed 1'

    }

  errorStrategy = { task.exitStatus in [1,143,137,104,134,139,255,108] ? 'retry' : 'finish' }
  maxRetries = 4
  maxErrors = '-1'
}

params {
    max_cpus   = 2
    max_memory = '6.5GB'
    max_time   = '4.h'
    igenomes_base = 'datasets_LABOS-2023/refs'

    genomes {
        'GRCh38chr21' {
            fasta                 = "${params.igenomes_base}/sequence/Homo_sapiens_assembly38_chr21.fasta"
            fasta_fai             = "${params.igenomes_base}/sequence/Homo_sapiens_assembly38_chr21.fasta.fai"
            gtf                   = "${params.igenomes_base}/annotations/gencode.v29.annotation_chr21.gtf"
        }
    }

}




``` 

_Make sure to click "i" for INSERT mode in vi editor, before paste the code_

## Launch nf-core/rnaseq


```{bash}
cd /home/YOUR-USER-NAME/

screen 

nextflow run nf-core/rnaseq -r 3.12.0 \
--input  data/reads/rnaseq_samplesheet.csv \
--outdir gs://mbg-bioinfomics-ms-data/newresults \
--genome GRCh38chr21 \
--pseudo_aligner salmon \
--skip_alignment \
--skip_biotype_qc \
-c nextflow.config \
-profile gls \
--skip_stringtie \
--skip_bigwig \
--skip_umi_extract \
--skip_trimming \
--skip_fastqc
```


_-[nf-core/rnaseq] Pipeline completed successfully -    
Completed at: 16-Nov-2023 10:44:43    
Duration    : 34m 59s    
CPU hours   : 0.2   
Succeeded   : 33_   


### Read results


In the ```results``` directory in your bucket, you should see now the salmon directory


To check file content you can copy a file using your cloud shell:
```

gsutil cp gs://results-in-your-bucket/salmon/salmon.merged.gene_counts.tsv .

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
“Ctrl-A” and “d“ without quotes.

To show the screen parameters, you can type:
“Ctrl-A” and “?” without quotes.


To terminate a screen window session
“ctrl-a” and “k” without quotes




###ERRORS/WARNS
WARN: Cannot read logs for Batch job 'nf-0382fc87-170012-18f1db27-c00c-49090' - cause: io.grpc.StatusRuntimeException: PERMISSION_DENIED: Permission denied for all resources




