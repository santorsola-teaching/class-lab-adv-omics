# Nextflow Environment Setup (CentOS Stream 9)

This repository contains automated scripts to deploy and manage a standardised Nextflow working environment on Google Cloud Platform (GCP) for high-throughput bioinformatics workflows.

---

## Execution Pipeline

Execute all commands directly in your **Google Cloud Shell** terminal.

| Script | Step | Description |
| :--- | :--- | :--- |
| `01_setup_nextflow_master.sh` | **Step 1** | Deploy Master VM & install core tools (Java, Git, Nextflow) |
| `02_create_nextflow_image.sh` | **Step 2** | Save VM disk state as a Custom Image |
| `03_launch_nextflow_from_image.sh` | **Step 3** | Launch operational working VM from saved image |


---

## Quick Start Guide

### Step 1: Deploy Initial Master VM
Creates a CentOS Stream 9 instance (e2-standard-4, 100GB Disk) and automatically installs Java 11, Git, Screen, and Nextflow 24.04.4.

Command:
sh 01_setup_nextflow_master.sh

(Wait ~2–3 minutes for system packages and Nextflow installation to complete)

---


Connect to your VM via ssh

gcloud compute ssh nextflow-master --zone=europe-west1-b

Press Enter to accept default SSH key prompts if asked)


Upon successful connection, you will see a host confirmation message:

Warning: Permanently added 'compute.6916671995707544335' (ED25519) to the list of known hosts.


### Verify tool installation:
Check startup log progress inside the VM:

sudo tail -f /var/log/startup-nextflow.log ## per 

sOnce completed, test the environment setup:



git --version

java -version

nextflow run hello

### Step 2: Save Reusable Custom Image
Stops the Master VM to safely capture the disk state, then creates a reusable custom image (nextflow-custom-image).

Command:
sh 02_create_nextflow_image.sh

(Wait ~2 minutes until the image creation process finishes)

---

When completed, you will see:
#Image nextflow-custom-image created successfully!
#You can now launch new Nextflow VMs instantly.


### Step 3: Launch Working VM from Image
Spin up your pre-configured Nextflow working environment directly from your custom image for daily practical work.

Command:
sh 03_launch_nextflow_from_image.sh

Connect to your VM via SSH:
gcloud compute ssh nextflow-work-vm --zone=europe-west1-b

---

## Important

- Save Grant Credits: Always stop your VM when not in use to avoid depleting your Google Cloud grant balance:
gcloud compute instances delete nextflow-master --zone=europe-west1-b --quiet


  gcloud compute instances stop nextflow-work-vm --zone=europe-west1-b
