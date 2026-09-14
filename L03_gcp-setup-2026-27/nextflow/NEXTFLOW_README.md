# Nextflow Environment Setup (CentOS Stream 9)

This repository contains automated scripts to deploy and manage a standardized Nextflow working environment on Google Cloud Platform (GCP) for high-throughput bioinformatics workflows.

---

## Execution Pipeline

Execute all commands directly in your **Google Cloud Shell** terminal.

- 01_setup_nextflow_master.sh: Step 1 - Deploy Master VM & Install Tools
- 02_create_nextflow_image.sh: Step 2 - Save VM state as a Custom Image
- 03_launch_nextflow_from_image.sh: Step 3 - Launch working VM from saved image

---

## Quick Start Guide

### Step 1: Deploy Initial Master VM
Creates a CentOS Stream 9 instance (e2-standard-4, 100GB Disk) and automatically installs Java 11, Git, Screen, and Nextflow 24.04.4.

Command:
sh 01_setup_nextflow_master.sh

(Wait ~2–3 minutes for system packages and Nextflow installation to complete)

---

### Step 2: Save Reusable Custom Image
Stops the Master VM to safely capture the disk state, then creates a reusable custom image (nextflow-custom-image).

Command:
sh 02_create_nextflow_image.sh

(Wait ~2 minutes until the image creation process finishes)

---

### Step 3: Launch Working VM from Image
Spin up your pre-configured Nextflow working environment directly from your custom image for daily practical work.

Command:
sh 03_launch_nextflow_from_image.sh

Connect to your VM via SSH:
gcloud compute ssh nextflow-work-vm --zone=europe-west1-b

---

## Essential Best Practices

- Save Grant Credits: Always stop your VM when not in use to avoid depleting your Google Cloud grant balance:
  gcloud compute instances stop nextflow-work-vm --zone=europe-west1-b
