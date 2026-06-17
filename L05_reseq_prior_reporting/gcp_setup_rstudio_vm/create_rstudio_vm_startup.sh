#!/bin/bash

# ==========================================================
# Usage on Cloud Shell terminal:
# sh create_rstudio_vm_startup.sh
# ==========================================================

# ==========================================================
# RSTUDIO VM CREATION SCRIPT (WITH FIREWALL AUTOMATION)
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
# NOTA: Rimosso il doppio backslash finale per evitare errori di sintassi in systemd
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
ExecStart=/usr/bin/docker run --name rstudio-vm --restart=always -p 8787:8787 -e DISABLE_AUTH=true ghcr.io/lescai-teaching/rstudio-docker-amd64:latest

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable rstudio-vm.service
systemctl start rstudio-vm.service
echo "RStudio systemd service setup complete. Container is starting."
'

# --- 3. CREATE THE VIRTUAL MACHINE (VM) INSTANCE ---
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

# --- 4. AUTOMATIC FIREWALL CONFIGURATION ---
echo "Checking and configuring firewall network rules for port 8787..."
# Il flag --quiet evita che gcloud chieda conferme interattive agli studenti
gcloud compute firewall-rules create allow-rstudio \
    --project="${PROJECT_ID}" \
    --allow=tcp:8787 \
    --target-tags=rstudio \
    --description="Consente accesso a RStudio Server su porta 8787" \
    --quiet 2>/dev/null || echo "Note: Firewall rule already exists or shared network used. Skipping."

echo "--------------------------------------------------------"
echo "VM creation and firewall configuration complete!"
echo "Wait 2-3 minutes for the container to download and start."
echo "Find the VM External IP, and access RStudio at: http://<EXTERNAL_IP>:8787"
echo "Authentication is disabled."
echo "--------------------------------------------------------"



# ==========================================================
# TROUBLESHOOTING / DEBUGGING COMMANDS
# ==========================================================
# To check if RStudio is running, run these in Cloud Shell:
# 
# 1. Connect to the VM:
#    gcloud compute ssh "${VM_NAME}" --zone="${VM_ZONE}"
#
# 2. Inside the VM, check the container status:
#    sudo docker ps -a
#
# 3. To exit the VM and return to Cloud Shell:
#    exit
# ==========================================================

