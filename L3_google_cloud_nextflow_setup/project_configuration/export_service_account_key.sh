### DEFINE YOUR ENVIRONMENT #########

PROJECT_ID= ###name your project
BUCKET_NAME= ###name your bucket - must be unique in all google region


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


## this must be executed in the same place where nextflow master process is run

export SERVICE_ACCOUNT_KEY_FILE=\${PWD}/${SERVICE_ACCOUNT_KEY}
export GOOGLE_APPLICATION_CREDENTIALS=\${PWD}/${SERVICE_ACCOUNT_KEY}

