# Launching the RStudio VM & executing the resequencing analysis

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

- Report template [report_sarek.Rmd](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L05_reseq_prior_reporting/reporting_template/report_sarek.Rmd)
- Annotation helper functions [extract_annotations_full.R](https://github.com/santorsola-teaching/class-lab-adv-omics/blob/main/L05_reseq_prior_reporting/code/extract_annotations_full.R):


## Step 3: Run the variant analysis & render the report

- Open ```report_sarek.Rmd``` inside RStudio.
- Verify that the file paths pointing to the VCF in your mounted bucket (```/home/rstudio/bucket_data```) and the R helper functions are correct.
- Run the code chunks to execute the analysis and click **Knit** to generate the final HTML report.

