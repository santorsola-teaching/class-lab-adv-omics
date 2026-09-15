# RStudio server environment setup (COS Container)

This repository contains automated scripts to deploy and manage a standardised RStudio Server working environment on Google Cloud Platform (GCP).

---

## Execution pipeline

To get started, download the setup scripts using wget:

```
wget https://raw.githubusercontent.com/santorsola-teaching/class-lab-adv-omics/refs/heads/main/L03_gcp-setup-2026-27/rstudio/04_setup_rstudio_master.sh
wget https://raw.githubusercontent.com/santorsola-teaching/class-lab-adv-omics/refs/heads/main/L03_gcp-setup-2026-27/rstudio/05_create_rstudio_image.sh
wget https://raw.githubusercontent.com/santorsola-teaching/class-lab-adv-omics/refs/heads/main/L03_gcp-setup-2026-27/rstudio/06_launch_rstudio_from_image.sh

```

Execute all commands directly in your **Google Cloud Shell** terminal.

| Script | Step | Description |
| :--- | :--- | :--- |
| `04_setup_rstudio_master.sh` | **Step 1** | Deploy master VM & configure RStudio |
| `05_create_rstudio_image.sh` | **Step 2** | Save Master VM state as a custom Image |
| `06_launch_rstudio_from_image.sh` | **Step 3** | Launch working VM from saved image |


---

## Quick start guide

### Step 1: Deploy the master VM
Deploys an e2-standard-2 instance on Container-Optimized OS (COS), pulls the course Docker container, and automatically configures firewall access for port 8787.

Command:
```
sh 04_setup_rstudio_master.sh
```

Wait ~2 minutes for the Docker container image to download and start.

---

### Step 2: Save reusable custom image

Command:
```
sh 05_create_rstudio_image.sh
```


Wait ~2 minutes until the image creation process finishes.

---

### Step 3: Launch the working RStudio VM from the image
Spin up an active RStudio instance from your saved image for daily practical work.

Command:
```
sh 06_launch_rstudio_from_image.sh
```

Navigate to the external IP address printed at the end of the script output:
```http://<EXTERNAL_IP>:8787``` and access via web browser.

Note: Authentication is disabled for course simplicity.

---

## Important

- Save grant credits: always stop your VM when not in use to avoid depleting your Google Cloud grant balance:
  ```gcloud compute instances stop rstudio-work-vm --zone=europe-west1-b```

