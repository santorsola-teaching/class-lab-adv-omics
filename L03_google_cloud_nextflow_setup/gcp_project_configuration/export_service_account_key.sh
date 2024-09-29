#!/bin/sh

# Usage: sh export_service_account_key.sh <your-project-name> 

### DEFINE YOUR ENVIRONMENT #########

PROJECT_ID=$1 ###name your project 
BUCKET_NAME=unipv-${PROJECT_ID#mbg-}-data-main ###name your bucket


#############################
## export service account key
#############################


## this follows previously used naming conventions

export PROJECT=`gcloud config list --format 'value(core.project)' 2>/dev/null`
export SERVICE_ACCOUNT_NAME=nextflow-service-account
export SERVICE_ACCOUNT_ADDRESS=${SERVICE_ACCOUNT_NAME}@${PROJECT}.iam.gserviceaccount.com
export SERVICE_ACCOUNT_KEY=${SERVICE_ACCOUNT_NAME}-private-key.json
       

## export key file

gcloud iam service-accounts keys create \
  --iam-account=${SERVICE_ACCOUNT_ADDRESS} \
  --key-file-type=json ${SERVICE_ACCOUNT_KEY}



