## IMPORTANT ALERT: Upcoming Deprecation of 'Deploy Container' 

The simpler method for launching containers on Container-Optimized OS (COS) via the Google Cloud Console's **"Deploy Container"** feature is being phased out in favor of more standard and robust deployment solutions.

**To ensure maximum reliability and preparation for the future, all students must use the dedicated Startup Script (`startup-script`) method for VM creation.**

The provided script, `create_rstudio_vm_startup.sh`, implements this robust solution using a `systemd` unit, resolving common issues like disk space and port conflicts.

For more details on migrating from the simple container launch option to using `cloud-init` or startup scripts, please refer to the official Google Cloud documentation:

[Migrate from Container-Optimized OS's container launch to cloud-init](https://docs.cloud.google.com/compute/docs/containers/migrate-containers?hl=it#cloud-init)

## How to Create Your RStudio VM

This script automates the entire setup process. **It must be run once in your Google Cloud Shell terminal.**

1.  **Open Cloud Shell:** Navigate to your Google Cloud Project and open the Cloud Shell terminal.
2.  **Download the Script:** Use `git` to clone the repository or download the script file (`create_rstudio_vm_startup.sh`).
3.  **Run the Script:** Execute the file in the Cloud Shell terminal:

    ```bash
    bash create_rstudio_vm_startup.sh
    ```

4.  **Wait and Access:** The process will take 2-3 minutes. Once the command finishes, find the External IP of the VM instance (`rstudio-master`) and access RStudio in your browser: `http://[External IP]:8787`.


