# Launching the RStudio VM & executing the Differential Expression analysis (DEA)

Follow these steps to spin up your dedicated RStudio Server instance from the pre-built image, load the analysis scripts, and build your variant prioritization report.

---

## Step 1: Spin up the RStudio VM

Execute the launch script from Cloud Shell to create the active VM instance:

```
bash 06_launch_rstudio_from_image.sh
```

Once execution completes, copy the external IP address printed in the terminal output and access the web interface via browser:
```
http://<EXTERNAL_IP>:8787
```

## Step 2: Upload analysis resources into RStudio
inside the RStudio Server interface.

- Report template [report_DEA_gcp.Rmd](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L09_rnaseq_DEA_reporting/reporting_template/report_DEA_gcp.Rmd)
- Table of gene/transcript identifiers [gencode.v29.transcripts_no-vers_chr21_tx2gene.txt](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L09_rnaseq_DEA_reporting/data/gencode.v29.transcripts_no-vers_chr21_tx2gene.txt):


## Step 3: Run the DEA & render the report

- Open ```report_DEA_gcp.Rmd``` inside RStudio.
- Verify that the file paths pointing to the `salmon` directory in your mounted bucket (```/home/rstudio/bucket_data```) and the table of gene/transcript identifiers are correct.


- Run the code chunks to execute the analysis and click **Knit** to generate the final HTML report.


