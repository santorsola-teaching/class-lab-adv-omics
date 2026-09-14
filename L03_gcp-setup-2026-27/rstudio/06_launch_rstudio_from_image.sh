#!/bin/bash
# ==========================================================
# 06_launch_rstudio_from_image.sh
# Launches a new RStudio VM from the Custom Image
# ==========================================================

export VM_NAME="rstudio-work-vm"
export IMAGE_NAME="rstudio-custom-image"
export FALLBACK_ZONE="europe-west1-b"
export VM_ZONE="$(gcloud config get-value compute/zone 2>/dev/null)"
export PROJECT_ID="$(gcloud config get-value project)"

if [[ -z "$VM_ZONE" ]]; then export VM_ZONE="$FALLBACK_ZONE"; fi

echo "Launching RStudio VM from ${IMAGE_NAME}..."
gcloud compute instances create "${VM_NAME}" \
    --project="${PROJECT_ID}" \
    --zone="${VM_ZONE}" \
    --machine-type=e2-standard-2 \
    --image="${IMAGE_NAME}" \
    --tags=rstudio \
    --boot-disk-size=50GB

# Assicura che la regola firewall esista
gcloud compute firewall-rules create allow-rstudio \
    --project="${PROJECT_ID}" \
    --allow=tcp:8787 \
    --target-tags=rstudio \
    --quiet 2>/dev/null || true

echo "--------------------------------------------------------"
echo "RStudio VM Ready!"
echo "Access RStudio in your browser at:"
echo "http://$(gcloud compute instances describe ${VM_NAME} --zone=${VM_ZONE} --format='get(networkInterfaces[0].accessConfigs[0].natIP)'):8787"
echo "--------------------------------------------------------"
