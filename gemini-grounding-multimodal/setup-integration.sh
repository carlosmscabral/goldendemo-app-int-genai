#!/bin/bash
# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# token=$(gcloud auth print-access-token)
# project=cabral-app-integration
# region=southamerica-east1

# integrationcli prefs set -p $project -r $region -t $token

# Export with: 
# integrationcli integrations scaffold -n gemini-multimodal -s 14 -e dev --cloud-build --cloud-deploy
# integrationcli integrations scaffold -n gemini-multimodal -s 14 -e dev --cloud-build --cloud-deploy --skip-connectors

# Deploy with: (change overrides for connection name to use the config variable name)
# integrationcli integrations apply -f . -e dev --wait=true