#!/bin/bash

# ==========================================================
# Usage on Cloud Shell terminal:
# sh create_rstudio_vm_startup.sh
# ==========================================================

#


# ==========================================================
# RSTUDIO VM CREATION SCRIPT (INLINE METADATA)
# This uses the most robust inline metadata passing syntax for gcloud.
# ==========================================================

# --- 1. SET ENVIRONMENT VARIABLES ---
export VM_NAME="rstudio-master"
export FALLBACK_ZONE="europe-west1-b"
export VM_ZONE="$(gcloud config get-value compute/zone 2>/dev/null)"
export PROJECT_ID="$(gcloud config get-value project)"

if [[ -z "$VM_ZONE" ]]; then
    export VM_ZONE="$FALLBACK_ZONE"
    echo "Warning: No default compute zone found. Using fallback zone: $VM_ZONE"
else
    echo "Using configured compute zone: $VM_ZONE"
fi

# --- 2. DEFINE THE RELIABLE STARTUP SCRIPT ---
# The script uses systemd and disables authentication.
# Single quotes ( ' ) ensure the script is passed as a single block to bash.

export STARTUP_SCRIPT='#!/bin/bash
UNIT_FILE="/etc/systemd/system/rstudio-vm.service"

cat <<EOF > "${UNIT_FILE}"
[Unit]
Description=RStudio Server Container
Requires=docker.service
After=docker.service

[Service]
TimeoutStartSec=0
Restart=always
ExecStartPre=-/usr/bin/docker rm -f rstudio-vm
# Authentication is disabled for student simplicity: DISABLE_AUTH=true
ExecStart=/usr/bin/docker run --name rstudio-vm \\
    --restart=always \\
    -p 8787:8787 \\
    -e DISABLE_AUTH=true \\
    ghcr.io/lescai-teaching/rstudio-docker-amd64:latest

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable rstudio-vm.service
systemctl start rstudio-vm.service
echo "RStudio systemd service setup complete. Container is starting."
'

# --- 3. CREATE THE VIRTUAL MACHINE (VM) INSTANCE ---
# FIX: Use the robust --metadata key=value syntax (comma-separated, no final backslash)
echo "Creating VM instance: ${VM_NAME} in zone ${VM_ZONE} with 50GB disk..."
gcloud compute instances create "${VM_NAME}" \
    --project="${PROJECT_ID}" \
    --zone="${VM_ZONE}" \
    --machine-type=e2-standard-2 \
    --image-family=cos-stable \
    --image-project=cos-cloud \
    --metadata=startup-script="$STARTUP_SCRIPT" \
    --tags=rstudio \
    --scopes=default \
    --boot-disk-size=50GB 

echo "--------------------------------------------------------"
echo "VM creation command sent successfully. This version is definitive."
echo "Wait 2-3 minutes, find the VM External IP, and access RStudio at port 8787."
echo "Authentication is disabled."
echo "--------------------------------------------------------"


