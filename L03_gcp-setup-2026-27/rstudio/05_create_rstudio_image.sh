#!/bin/bash
# ==========================================================
# 05_create_rstudio_image.sh
# Stops the RStudio Master VM and creates a Custom Image
# ==========================================================

export VM_NAME="rstudio-master"
export IMAGE_NAME="rstudio-custom-image"
export FALLBACK_ZONE="europe-west1-b"
export VM_ZONE="$(gcloud config get-value compute/zone 2>/dev/null)"

if [[ -z "$VM_ZONE" ]]; then export VM_ZONE="$FALLBACK_ZONE"; fi

echo "Stopping ${VM_NAME}..."
gcloud compute instances stop "${VM_NAME}" --zone="${VM_ZONE}" --quiet

echo "Creating Custom Image ${IMAGE_NAME}..."
gcloud compute images create "${IMAGE_NAME}" \
    --source-disk="${VM_NAME}" \
    --source-disk-zone="${VM_ZONE}" \
    --family="rstudio-labos"

echo "--------------------------------------------------------"
echo "Image ${IMAGE_NAME} created successfully!"
echo "--------------------------------------------------------"