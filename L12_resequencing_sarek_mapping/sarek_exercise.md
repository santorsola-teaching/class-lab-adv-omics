# nf-core/sarek - mapping

## Set your working place

- Create your VM instance from Google Cloud Console.

- Install the required tools on you VM instance


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

File available in ```datasets_LABOS-2023/germline/reads/sarek_samplesheet.csv```.

```
patient,sample,lane,fastq_1,fastq_2
patient_01,sample_01,lane1,datasets_LABOS-2023/germline/reads/case_1.fastq.gz,datasets_LABOS-2023/germline/reads/case_2.fastq.gz
patient_02,sample_02,lane1,datasets_LABOS-2023/germline/reads/control_1.fastq.gz,datasets_LABOS-2023/germline/reads/control_2.fastq.gz
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
    igenomes_base = '/home/YOUR-USER-NAME/datasets_LABOS-2023/refs'

    genomes {
        'GRCh38chr21' {
            bwa                   = "${params.igenomes_base}/sequence/Homo_sapiens_assembly38_chr21.fasta.{amb,ann,bwt,pac,sa}"
            dbsnp                 = "${params.igenomes_base}/annotations/dbsnp_146.hg38_chr21.vcf.gz"
            dbsnp_tbi             = "${params.igenomes_base}/annotations/dbsnp_146.hg38_chr21.vcf.gz.tbi"
            dbsnp_vqsr            = '--resource:dbsnp,known=false,training=true,truth=false,prior=2.0 dbsnp_146.hg38_chr21.vcf.gz'
            dict                  = "${params.igenomes_base}/sequence/Homo_sapiens_assembly38_chr21.dict"
            fasta                 = "${params.igenomes_base}/sequence/Homo_sapiens_assembly38_chr21.fasta"
            fasta_fai             = "${params.igenomes_base}/sequence/Homo_sapiens_assembly38_chr21.fasta.fai"
            germline_resource     = "${params.igenomes_base}/annotations/gnomAD.r2.1.1.GRCh38.PASS.AC.AF.only_chr21.vcf.gz"
            germline_resource_tbi = "${params.igenomes_base}/annotations/gnomAD.r2.1.1.GRCh38.PASS.AC.AF.only_chr21.vcf.gz.tbi"
            known_snps            = "${params.igenomes_base}/annotations/1000G_phase1.snps.high_confidence.hg38_chr21.vcf.gz"
            known_snps_tbi        = "${params.igenomes_base}/annotations/1000G_phase1.snps.high_confidence.hg38_chr21.vcf.gz.tbi"
            known_snps_vqsr       = '--resource:1000G,known=false,training=true,truth=true,prior=10.0 1000G_phase1.snps.high_confidence.hg38_chr21.vcf.gz'
            known_indels          = "${params.igenomes_base}/annotations/Mills_and_1000G_gold_standard.indels.hg38_chr21.vcf.gz"
            known_indels_tbi      = "${params.igenomes_base}/annotations/Mills_and_1000G_gold_standard.indels.hg38_chr21.vcf.gz.tbi"
            known_indels_vqsr     = '--resource:mills,known=false,training=true,truth=true,prior=10.0 Mills_and_1000G_gold_standard.indels.hg38_chr21.vcf.gz'
            snpeff_db     = '105'
            snpeff_genome = 'GRCh38'
        }
    }

    use_annotation_cache_keys = true
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

## Launch nf-core/sarek: single sample calling


```{bash}
cd /home/YOUR-USER-NAME/

screen 

nextflow run nf-core/sarek -r 3.3.2 \
--input datasets_LABOS-2023/germline/reads/sarek_samplesheet.csv \
--outdir gs://results-in-your-bucket \
--tools haplotypecaller,snpeff \
--genome GRCh38chr21 \
--skip_tools haplotypecaller_filter \
-c nextflow.config \
-profile gls
```

_-[nf-core/sarek] Pipeline completed successfully-  
Completed at: 26-Oct-2023 09:38:54  
Duration    : 38m 42s  
CPU hours   : 0.8  
Succeeded   : 44_  




## Launch nf-core/sarek: joint variant calling
```
nextflow run nf-core/sarek -r 3.3.2 \
--input datasets_LABOS-2023/germline/reads/sarek_samplesheet.csv \
--outdir gs://results-in-your-bucket  \
--tools haplotypecaller,snpeff \
--genome GRCh38chr21 \
--joint_germline \
--intervals datasets_LABOS-2023/germline/chr21_intervals.list \
-c nextflow.config \
-profile gls
```

_-[nf-core/sarek] Pipeline completed successfully-
Completed at: 26-Oct-2023 10:45:23  
Duration    : 55m 22s  
CPU hours   : 1.0  
Succeeded   : 45_  


### Read results


In the ```results``` directory in your bucket, you should see now:
- a single VCF file from joint variant calling
- one VCF file for sample_01
- one VCF file for sample_02

To copy you VCF files, you can type on your cloud shell:
```
gsutil cp gs://results-in-your-bucket/annotation/haplotypecaller/joint_variant_calling/joint_germline_recalibrated_snpEff.ann.vcf.gz .

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





