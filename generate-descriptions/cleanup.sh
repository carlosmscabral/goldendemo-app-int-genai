#!/bin/bash

if [ -z "$PROJECT_ID" ]; then
  echo "No PROJECT_ID variable set"
  exit
fi

if [ -z "$LOCATION" ]; then
  echo "No LOCATION variable set"
  exit
fi

TOKEN=$(gcloud auth print-access-token)

echo "Installing integrationcli ..."
curl -L https://raw.githubusercontent.com/GoogleCloudPlatform/application-integration-management-toolkit/main/downloadLatest.sh | sh -
export PATH=$PATH:$HOME/.integrationcli/bin
integrationcli token cache -t $TOKEN
integrationcli prefs set --reg=$LOCATION --proj=$PROJECT_ID

echo "Cleaning up..."

integrationcli integrations delete -n api-hub-version-approval
integrationcli integrations delete -n repo-creation-notification

gcloud deploy delivery-pipelines delete apigee-pipeline --region=us-central1 --force --quiet
gcloud deploy custom-target-types delete apigee-custom-target --region=us-central1 --quiet
gcloud builds triggers delete apigee-golden-path-create-repo
gcloud secrets delete cloudbuild-webhook-secret --quiet
gcloud eventarc triggers delete apihub-new-spec --location=us-central1
gcloud workflows delete apihub-new-spec-dummy --location=us-central1 --quiet
gcloud iam service-accounts delete api-hub-integration@$PROJECT_ID.iam.gserviceaccount.com --quiet

echo "DONE"