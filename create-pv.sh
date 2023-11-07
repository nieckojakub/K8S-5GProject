#!/bin/bash
# Create persistent volume for free5gc mongodb database
# script based on https://github.com/nrg-uw/5g-manifests/blob/main/create-free5gc-pv.sh

# Define variables
PV_NAME="free5gc-local-pv"
PV_PATH="/home/worker03/kubedata"
PV_NODE="k8-worker03"

# Check if required variables are set
if [ -z "$PV_NAME" ] || [ -z "$PV_PATH" ] || [ -z "$PV_NODE" ]; then
  echo "One or more required variables are not set."
  echo "Please set PV_NAME, PV_PATH, and PV_NODE to valid values."
  exit 1
fi

# Create persistent volume
kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: $PV_NAME
  labels:
    project: free5gc
spec:
  capacity:
    storage: 8Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  local:
    path: $PV_PATH
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - $PV_NODE
EOF