token=$(gcloud auth print-access-token)
project=cabral-app-integration
region=southamerica-east1

integrationcli prefs set -p $project -r $region -t $token