############################################
## this can be executed on a terminal
## where Google Cloud CLI has been installed
#############################################

### DEFINE YOUR ENVIRONMENT #########

PROJECT_ID= ###name your project
BUCKET_NAME= ###name your bucket - must be unique in all google region


## set project on CLI

gcloud config set project ${PROJECT_ID}


## enabling APIs

## life science API
gcloud services enable lifesciences.googleapis.com
## compute API
gcloud services enable compute.googleapis.com
## storage API
gcloud services enable storage.googleapis.com


## cloud resource manager API
gcloud services enable cloudresourcemanager.googleapis.com

## IAM resource manager API
gcloud services enable iam.googleapis.com

## GOOGLE CLOUD BATCH (for nextflow 2023)

## cloud batch
gcloud services enable batch.googleapis.com

## logging api
gcloud services enable logging.googleapis.com


## set correct region
## google batch can be executed where enabled

gcloud config set compute/region europe-west4
gcloud config set compute/zone europe-west4-a


######################################
## create a storage bucket ###########
######################################

gcloud storage buckets \
create gs://${BUCKET_NAME} \
--location=europe-west4 \
--uniform-bucket-level-access \
--public-access-prevention


## create service account for nextflow

export PROJECT=${PROJECT_ID}
export SERVICE_ACCOUNT_NAME=nextflow-service-account
export SERVICE_ACCOUNT_ADDRESS=${SERVICE_ACCOUNT_NAME}@${PROJECT}.iam.gserviceaccount.com

gcloud iam service-accounts create ${SERVICE_ACCOUNT_NAME} --display-name=${SERVICE_ACCOUNT_NAME}

#### add the necessary policies to the service account
#### according to nextflow usage

gcloud projects add-iam-policy-binding ${PROJECT} \
    --member serviceAccount:${SERVICE_ACCOUNT_ADDRESS} \
    --role roles/lifesciences.workflowsRunner

gcloud projects add-iam-policy-binding ${PROJECT} \
    --member serviceAccount:${SERVICE_ACCOUNT_ADDRESS} \
    --role roles/iam.serviceAccountUser

gcloud projects add-iam-policy-binding ${PROJECT} \
    --member serviceAccount:${SERVICE_ACCOUNT_ADDRESS} \
    --role roles/serviceusage.serviceUsageConsumer

gcloud projects add-iam-policy-binding ${PROJECT} \
    --member serviceAccount:${SERVICE_ACCOUNT_ADDRESS} \
    --role roles/storage.objectAdmin

gcloud projects add-iam-policy-binding ${PROJECT} \
    --member serviceAccount:${SERVICE_ACCOUNT_ADDRESS} \
    --role roles/batch.agentReporter

gcloud projects add-iam-policy-binding ${PROJECT} \
    --member serviceAccount:${SERVICE_ACCOUNT_ADDRESS} \
    --role roles/storage.admin

gcloud projects add-iam-policy-binding ${PROJECT} \
    --member serviceAccount:${SERVICE_ACCOUNT_ADDRESS} \
    --role roles/batch.jobsEditor

gcloud projects add-iam-policy-binding ${PROJECT} \
    --member serviceAccount:${SERVICE_ACCOUNT_ADDRESS} \
    --role roles/storage.objectAdmin

gcloud projects add-iam-policy-binding ${PROJECT} \
    --member serviceAccount:${SERVICE_ACCOUNT_ADDRESS} \
    --role roles/iam.serviceAccountUser


