#!/bin/bash

export VM_NAME="nextflow-master"
export FALLBACK_ZONE="europe-west1-b"
export VM_ZONE="$(gcloud config get-value compute/zone 2>/dev/null)"
export PROJECT_ID="$(gcloud config get-value project)"

if [[ -z "$VM_ZONE" ]]; then
    export VM_ZONE="$FALLBACK_ZONE"
    echo "Warning: No default compute zone found. Using fallback zone: $VM_ZONE"
else
    echo "Using configured compute zone: $VM_ZONE"
fi

echo "Creating Nextflow Master VM..."

# Create clean temporary startup script file
cat << 'EOF' > /tmp/startup.sh
#!/bin/bash
exec > /var/log/startup-nextflow.log 2>&1
echo "Starting system setup for CentOS Stream 9..."

# Update EPEL and repositories
yum install -y epel-release
yum update -y --nogpgcheck

# Install core tools and Java 11
yum install -y git java-11-openjdk-devel screen curl

# Set global environment variables
cat << 'ENVEOF' > /etc/profile.d/nextflow.sh
export NXF_VER=24.04.4
export NXF_MODE=google
export PATH=$PATH:/usr/local/bin
ENVEOF

chmod +x /etc/profile.d/nextflow.sh

# Download and install Nextflow globally
export NXF_VER=24.04.4
export NXF_MODE=google

cd /tmp
curl -s https://get.nextflow.io | bash
mv nextflow /usr/local/bin/
chmod +x /usr/local/bin/nextflow

echo "Nextflow setup complete!"
EOF

# Deploy VM passing script safely via --metadata-from-file
gcloud compute instances create "${VM_NAME}" \
    --project="${PROJECT_ID}" \
    --zone="${VM_ZONE}" \
    --machine-type=e2-standard-4 \
    --image-family=centos-stream-9 \
    --image-project=centos-cloud \
    --metadata-from-file=startup-script=/tmp/startup.sh \
    --scopes=cloud-platform \
    --boot-disk-size=100GB

# Clean local temp file
rm -f /tmp/startup.sh

echo "--------------------------------------------------------"
echo "VM creation complete!"
echo "Wait ~2-3 minutes for background installation to finish."
echo "Connect with: gcloud compute ssh ${VM_NAME} --zone=${VM_ZONE}"
echo "--------------------------------------------------------"
