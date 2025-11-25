## IMPORTANT ALERT: Upcoming Deprecation of 'Deploy Container' 

The simpler method for launching containers on Container-Optimized OS (COS) via the Google Cloud Console's **"Deploy Container"** feature is being phased out in favor of more standard and robust deployment solutions.

**To ensure maximum reliability and preparation for the future, all students must use the dedicated Startup Script (`startup-script`) method for VM creation.**

The provided script, `create_rstudio_vm_startup.sh`, implements this robust solution using a `systemd` unit, resolving common issues like disk space and port conflicts.

For more details on migrating from the simple container launch option to using `cloud-init` or startup scripts, please refer to the official Google Cloud documentation:

[Migrate from Container-Optimized OS's container launch to cloud-init](https://docs.cloud.google.com/compute/docs/containers/migrate-containers?hl=it#cloud-init)
