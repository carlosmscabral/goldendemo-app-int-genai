#!/bin/bash

if [ -z "$PROJECT_ID" ]; then
  echo "No PROJECT_ID variable set"
  exit
fi

if [ -z "$REGION" ]; then
  echo "No REGION variable set"
  exit
fi


###########################
# Assumes BQ Dataset Exists already
# Assumes table already exists and is named houses
###########################


# deploy integration flows
echo "Deploying app integration flows..."

echo "Installing integrationcli ..."
curl -L https://raw.githubusercontent.com/GoogleCloudPlatform/application-integration-management-toolkit/main/downloadLatest.sh | sh -
export PATH=$PATH:$HOME/.integrationcli/bin
TOKEN=$(gcloud auth print-access-token)
integrationcli token cache -t $TOKEN
integrationcli prefs set --reg=$REGION --proj=$PROJECT_ID


integrationcli integrations apply -f . -e dev --wait=true

