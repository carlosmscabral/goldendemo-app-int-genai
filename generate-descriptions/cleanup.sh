#!/bin/bash

if [ -z "$PROJECT_ID" ]; then
  echo "No PROJECT_ID variable set"
  exit
fi

if [ -z "$REGION" ]; then
  echo "No REGION variable set"
  exit
fi

TOKEN=$(gcloud auth print-access-token)

echo "Installing integrationcli ..."
curl -L https://raw.githubusercontent.com/GoogleCloudPlatform/application-integration-management-toolkit/main/downloadLatest.sh | sh -
export PATH=$PATH:$HOME/.integrationcli/bin
integrationcli token cache -t $TOKEN
integrationcli prefs set --reg=$REGION --proj=$PROJECT_ID

echo "Cleaning up..."

integrationcli integrations delete -n generate-house-descriptions

bq query --use_legacy_sql=false 'UPDATE `cabral-app-integration.cabral_dataset.houses` SET GenerativeDescription = "" WHERE 1=1;'

echo "DONE"