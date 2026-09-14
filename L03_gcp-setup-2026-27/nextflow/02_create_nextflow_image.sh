#!/bin/bash
# ==========================================================
# 02_create_nextflow_image.sh
# Stops the Nextflow Master VM and creates a Custom Image
# ==========================================================

export VM_NAME="nextflow-master"
export IMAGE_NAME="nextflow-custom-image"
export FALLBACK_ZONE="europe-west1-b"
export VM_ZONE="$(gcloud config get-value compute/zone 2>/dev/null)"

if [[ -z "$VM_ZONE" ]]; then export VM_ZONE="$FALLBACK_ZONE"; fi

echo "Stopping ${VM_NAME}..."
gcloud compute instances stop "${VM_NAME}" --zone="${VM_ZONE}" --quiet

echo "Creating Custom Image ${IMAGE_NAME}..."
gcloud compute images create "${IMAGE_NAME}" \
    --source-disk="${VM_NAME}" \
    --source-disk-zone="${VM_ZONE}" \
    --family="nextflow-labos"

echo "--------------------------------------------------------"
echo "Image ${IMAGE_NAME} created successfully!"
echo "You can now launch new Nextflow VMs instantly."
echo "--------------------------------------------------------"