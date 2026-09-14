#!/bin/bash
# ==========================================================
# 04_setup_rstudio_master.sh
# Creates the RStudio Master VM with Docker service and Firewall
# ==========================================================

export VM_NAME="rstudio-master"
export FALLBACK_ZONE="europe-west1-b"
export VM_ZONE="$(gcloud config get-value compute/zone 2>/dev/null)"
export PROJECT_ID="$(gcloud config get-value project)"

if [[ -z "$VM_ZONE" ]]; then export VM_ZONE="$FALLBACK_ZONE"; fi

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
ExecStart=/usr/bin/docker run --name rstudio-vm --restart=always -p 8787:8787 -e DISABLE_AUTH=true ghcr.io/lescai-teaching/rstudio-docker-amd64:latest

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable rstudio-vm.service
systemctl start rstudio-vm.service
'

echo "Creating RStudio Master VM..."
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

echo "Configuring firewall for port 8787..."
gcloud compute firewall-rules create allow-rstudio \
    --project="${PROJECT_ID}" \
    --allow=tcp:8787 \
    --target-tags=rstudio \
    --description="Allow RStudio traffic" \
    --quiet 2>/dev/null || echo "Firewall rule already exists. Skipping."

echo "--------------------------------------------------------"
echo "VM creation complete!"
echo "Wait ~2 minutes, then access RStudio at:"
echo "http://$(gcloud compute instances describe ${VM_NAME} --zone=${VM_ZONE} --format='get(networkInterfaces[0].accessConfigs[0].natIP)'):8787"
echo "--------------------------------------------------------"