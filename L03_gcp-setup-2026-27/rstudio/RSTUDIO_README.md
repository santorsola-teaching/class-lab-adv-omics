# RStudio Server Environment Setup (COS Container)

This repository contains automated scripts to deploy and manage a standardized RStudio Server working environment on Google Cloud Platform (GCP).

---

## Execution Pipeline

Execute all commands directly in your **Google Cloud Shell** terminal.

- 04_setup_rstudio_master.sh: Step 1 - Deploy Master VM & Configure RStudio
- 05_create_rstudio_image.sh: Step 2 - Save VM state as a Custom Image
- 06_launch_rstudio_from_image.sh: Step 3 - Launch working VM from saved image

---

## Quick Start Guide

### Step 1: Deploy Initial Master VM
Deploys an e2-standard-2 instance on Container-Optimized OS (COS), pulls the course Docker container, and automatically configures firewall access for port 8787.

Command:
sh 04_setup_rstudio_master.sh

(Wait ~2 minutes for the Docker container image to download and start)

---

### Step 2: Save Reusable Custom Image
Stops the Master VM to safely capture the container configuration, then creates a reusable custom image (rstudio-custom-image).

Command:
sh 05_create_rstudio_image.sh

(Wait ~2 minutes until the image creation process finishes)

---

### Step 3: Launch Working VM from Image
Spin up an active RStudio instance from your saved image for daily practical work.

Command:
sh 06_launch_rstudio_from_image.sh

Access via Web Browser:
Navigate to the external IP address printed at the end of the script output:
http://<EXTERNAL_IP>:8787

Note: Authentication is disabled for course simplicity.

---

## Essential Best Practices

- Save Grant Credits: Always stop your VM when not in use to avoid depleting your Google Cloud grant balance:
  gcloud compute instances stop rstudio-work-vm --zone=europe-west1-b