# Nextflow environment setup (CentOS Stream 9)

This repository contains automated scripts to deploy and manage a standardised Nextflow working environment on Google Cloud Platform (GCP) for nf-core pipelines.

---

## Execution pipeline

Execute all commands directly in your **Google Cloud Shell** terminal.

| Script | Step | Description |
| :--- | :--- | :--- |
| `01_setup_nextflow_master.sh` | **Step 1** | Deploy master VM & install core tools (Java, Git, Nextflow) |
| `02_create_nextflow_image.sh` | **Step 2** | Save master VM disk state as a custom image |
| `03_launch_nextflow_from_image.sh` | **Step 3** | Launch operational working VM from saved image |


---

## Quick start guide

### Step 1: Deploy the Master VM
Creates a CentOS Stream 9 instance (e2-standard-4, 100GB Disk) and automatically installs Java 11, Git, Screen, and Nextflow 24.04.4.

Command:
```
sh 01_setup_nextflow_master.sh
```

Wait ~2–3 minutes for system packages and Nextflow installation to complete.

---


#### Connect to your VM via ssh
```
gcloud compute ssh nextflow-master --zone=europe-west1-b
```
During the first connection, gcloud will automatically configure your SSH keys and ask a few interactive setup questions.

Steps to follow during setup:

Directory creation prompt:
```
This tool needs to create the directory [.../.ssh] before being able to generate SSH keys.
Do you want to continue (Y/n)?```  → Type ```Y``` and press ```Enter```.

Passphrase prompts:
```Enter passphrase (empty for no passphrase):``` → Press ```Enter``` (leave empty).
```Enter same passphrase again:``` → Press ```Enter``` again.

Expected Output:

After pressing Enter, you will see an output similar to this, showing key generation and project metadata update:
```
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/user/.ssh/google_compute_engine
Your public key has been saved in /home/user/.ssh/google_compute_engine.pub
The key fingerprint is:
SHA256:... user@cloud-shell
The key's randomart image is:
+---[RSA 3072]----+
|    =oo+ .       |
|    . @. +       |
+----[SHA256]-----+
Updating project ssh metadata...working..Updated [...]
```


Upon successful connection, you will see a host confirmation message:
```
Warning: Permanently added 'compute.6916671995707544335' (ED25519) to the list of known hosts.
```

#### Verify tool installation:
Check startup log progress inside the VM:
```
sudo tail -f /var/log/startup-nextflow.log
```
Once completed, test the environment setup:
```
git --version

java -version

nextflow run hello
```
### Step 2: Save reusable custom image

Command:
```
sh 02_create_nextflow_image.sh
```
Wait ~2 minutes until the image creation process finishes.

---

When completed, you will see:
```
Image nextflow-custom-image created successfully!
You can now launch new Nextflow VMs instantly.
```

### Step 3: Launch Working VM from Image
Spin up your pre-configured Nextflow working environment directly from your custom image for daily practical work.

Command:
```
sh 03_launch_nextflow_from_image.sh
```

Connect to your VM via SSH:
```
gcloud compute ssh nextflow-work-vm --zone=europe-west1-b
```

Once updated, your shell will automatically log into the VM and the prompt will change to ```username@nextflow-master:~$```

---

## Important

- Save grant credits: always stop your VM when not in use to avoid depleting your Google Cloud grant balance:
```
gcloud compute instances delete nextflow-master --zone=europe-west1-b --quiet

gcloud compute instances stop nextflow-work-vm --zone=europe-west1-

```


