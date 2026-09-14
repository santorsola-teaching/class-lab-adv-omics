#!/bin/bash
# ==========================================================
# 03_launch_nextflow_from_image.sh
# Launches a new Nextflow VM from the Custom Image
# ==========================================================

export VM_NAME="nextflow-work-vm"
export IMAGE_NAME="nextflow-custom-image"
export FALLBACK_ZONE="europe-west1-b"
export VM_ZONE="$(gcloud config get-value compute/zone 2>/dev/null)"
export PROJECT_ID="$(gcloud config get-value project)"

if [[ -z "$VM_ZONE" ]]; then export VM_ZONE="$FALLBACK_ZONE"; fi

echo "Launching Nextflow VM from ${IMAGE_NAME}..."
gcloud compute instances create "${VM_NAME}" \
    --project="${PROJECT_ID}" \
    --zone="${VM_ZONE}" \
    --machine-type=e2-standard-4 \
    --image="${IMAGE_NAME}" \
    --scopes=cloud-platform \
    --boot-disk-size=100GB

echo "--------------------------------------------------------"
echo "VM Ready! Connect via SSH:"
echo "gcloud compute ssh ${VM_NAME} --zone=${VM_ZONE}"
echo "--------------------------------------------------------"