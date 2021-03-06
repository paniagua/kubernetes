#!/bin/bash

# Copyright 2014 The Kubernetes Authors All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# TODO(jbeda): Provide a way to override project
# gcloud multiplexing for shared GCE/GKE tests.
GCLOUD=gcloud
ZONE=${KUBE_GCE_ZONE:-us-central1-b}
MASTER_SIZE=${MASTER_SIZE:-g1-small}
MINION_SIZE=${MINION_SIZE:-g1-small}
NUM_MINIONS=${NUM_MINIONS:-2}
MASTER_DISK_TYPE=pd-standard
MASTER_DISK_SIZE=${MASTER_DISK_SIZE:-100GB}
MINION_DISK_TYPE=pd-standard
MINION_DISK_SIZE=${MINION_DISK_SIZE:-100GB}

OS_DISTRIBUTION=${KUBE_OS_DISTRIBUTION:-debian}
MASTER_IMAGE=${KUBE_GCE_MASTER_IMAGE:-container-vm-v20150505}
MASTER_IMAGE_PROJECT=${KUBE_GCE_MASTER_PROJECT:-google-containers}
MINION_IMAGE=${KUBE_GCE_MINION_IMAGE:-container-vm-v20150505}
MINION_IMAGE_PROJECT=${KUBE_GCE_MINION_PROJECT:-google-containers}
CONTAINER_RUNTIME=${KUBE_CONTAINER_RUNTIME:-docker}

NETWORK=${KUBE_GCE_NETWORK:-e2e}
INSTANCE_PREFIX="${KUBE_GCE_INSTANCE_PREFIX:-e2e-test-${USER}}"
MASTER_NAME="${INSTANCE_PREFIX}-master"
MASTER_TAG="${INSTANCE_PREFIX}-master"
MINION_TAG="${INSTANCE_PREFIX}-minion"
CLUSTER_IP_RANGE="${CLUSTER_IP_RANGE:-10.245.0.0/16}"
MASTER_IP_RANGE="${MASTER_IP_RANGE:-10.246.0.0/24}"
MINION_SCOPES=("storage-ro" "compute-rw" "https://www.googleapis.com/auth/logging.write" "https://www.googleapis.com/auth/monitoring")
# Increase the sleep interval value if concerned about API rate limits. 3, in seconds, is the default.
POLL_SLEEP_INTERVAL=3
PORTAL_NET="10.0.0.0/16"

# When set to true, Docker Cache is enabled by default as part of the cluster bring up.
ENABLE_DOCKER_REGISTRY_CACHE=true

# Optional: Install node monitoring.
ENABLE_NODE_MONITORING="${KUBE_ENABLE_NODE_MONITORING:-true}"

# Optional: Cluster monitoring to setup as part of the cluster bring up:
#   none     - No cluster monitoring setup 
#   influxdb - Heapster, InfluxDB, and Grafana 
#   google   - Heapster, Google Cloud Monitoring, and Google Cloud Logging 
ENABLE_CLUSTER_MONITORING="${KUBE_ENABLE_CLUSTER_MONITORING:-influxdb}"

# Optional: Enable node logging.
ENABLE_NODE_LOGGING="${KUBE_ENABLE_NODE_LOGGING:-true}"
LOGGING_DESTINATION="${KUBE_LOGGING_DESTINATION:-elasticsearch}" # options: elasticsearch, gcp

# Optional: When set to true, Elasticsearch and Kibana will be setup as part of the cluster bring up.
ENABLE_CLUSTER_LOGGING="${KUBE_ENABLE_CLUSTER_LOGGING:-true}"
ELASTICSEARCH_LOGGING_REPLICAS=1

# Don't require https for registries in our local RFC1918 network
EXTRA_DOCKER_OPTS="--insecure-registry 10.0.0.0/8"

# Optional: Install cluster DNS.
ENABLE_CLUSTER_DNS=true
DNS_SERVER_IP="10.0.0.10"
DNS_DOMAIN="kubernetes.local"
DNS_REPLICAS=1

ADMISSION_CONTROL=NamespaceAutoProvision,LimitRanger,SecurityContextDeny,ResourceQuota
