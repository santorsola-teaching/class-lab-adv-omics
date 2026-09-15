#!/bin/bash
# ==========================================================
# 04_setup_rstudio_master.sh
# Creates the RStudio Master VM with Docker service and Firewall
# ==========================================================


export VM_NAME="rstudio-master"
export PROJECT_ID="$(gcloud config get-value project 2>/dev/null)"

ZONES=("europe-west1-b" "europe-west1-c" "europe-west1-d" "europe-west4-a")

export BUCKET_NAME="$(gcloud storage buckets list --format="value(name)" 2>/dev/null | head -n 1)"

if [[ -z "$BUCKET_NAME" ]]; then
    echo "ERROR: No Google Cloud Storage bucket found in project '${PROJECT_ID}'."
    exit 1
fi

echo "Automatically detected bucket: ${BUCKET_NAME}"

export STARTUP_SCRIPT='#!/bin/bash
apt-get update
apt-get install -y curl fuse lsb-release ca-certificates docker.io

GCSFUSE_REPO="gcsfuse-$(lsb_release -cs)"
echo "deb https://packages.cloud.google.com/apt $GCSFUSE_REPO main" | tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

apt-get update
apt-get install -y gcsfuse

mkdir -p /var/gcsdata
chmod 777 /var/gcsdata
sed -i "s/#user_allow_other/user_allow_other/g" /etc/fuse.conf

cat <<EOF > /etc/systemd/system/gcsfuse-mount.service
[Unit]
Description=Mount GCS Bucket via gcsfuse
After=network-online.target
Wants=network-online.target

[Service]
Type=forking
ExecStart=/usr/bin/gcsfuse --implicit-dirs -o allow_other '$BUCKET_NAME' /var/gcsdata
ExecStop=/bin/fusermount -u /var/gcsdata
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

cat <<EOF > /etc/systemd/system/rstudio-vm.service
[Unit]
Description=RStudio Server Container
Requires=docker.service gcsfuse-mount.service
After=docker.service gcsfuse-mount.service

[Service]
TimeoutStartSec=0
Restart=always
ExecStartPre=-/usr/bin/docker rm -f rstudio-vm
ExecStart=/usr/bin/docker run --name rstudio-vm \
    --restart=always \
    -p 8787:8787 \
    -e DISABLE_AUTH=true \
    -v /var/gcsdata:/home/rstudio/bucket_data:shared \
    ghcr.io/lescai-teaching/rstudio-docker-amd64:latest

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable gcsfuse-mount.service rstudio-vm.service
systemctl start gcsfuse-mount.service rstudio-vm.service
'

echo "Creating RStudio Master VM..."
VM_CREATED=false

for ZONE in "${ZONES[@]}"; do
    echo "Tentativo di creazione VM nella zona: ${ZONE}..."
    if gcloud compute instances create "${VM_NAME}" \
        --project="${PROJECT_ID}" \
        --zone="${ZONE}" \
        --machine-type=e2-standard-2 \
        --image-family=ubuntu-2204-lts \
        --image-project=ubuntu-os-cloud \
        --metadata=startup-script="$STARTUP_SCRIPT" \
        --tags=rstudio \
        --scopes=cloud-platform \
        --boot-disk-size=50GB; then
        
        export VM_ZONE="${ZONE}"
        VM_CREATED=true
        echo "VM successfully created in zone: ${ZONE}!"
        break
    else
        echo "Zone ${ZONE} unavailable or experiencing an error. Trying the next one..."
    fi
done

if [ "$VM_CREATED" = false ]; then
    echo "CRITICAL ERROR: Unable to create VM in any of the specified zones."
    exit 1
fi

echo "Configuring firewall for port 8787..."
gcloud compute firewall-rules create allow-rstudio \
    --project="${PROJECT_ID}" \
    --allow=tcp:8787 \
    --target-tags=rstudio \
    --description="Allow RStudio traffic" \
    --quiet 2>/dev/null || echo "Firewall rule already exists. Skipping."

echo "--------------------------------------------------------"
echo "VM creation complete!"
echo "Mounted bucket: ${BUCKET_NAME} -> /home/rstudio/bucket_data"
echo "Access RStudio in ~2 minutes at:"
echo "http://$(gcloud compute instances describe ${VM_NAME} --zone=${VM_ZONE} --format='get(networkInterfaces[0].accessConfigs[0].natIP)'):8787"
echo "--------------------------------------------------------"

