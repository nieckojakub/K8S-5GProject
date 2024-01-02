#!/usr/bin/env bash

NF_LIST3="upf1 upf2 nrf amf udr udm nssf ausf pcf smf1 smf2 webui"
NF_LIST5="upf1 nrf amf udr udm nssf ausf pcf smf1 webui"

kubectl apply  -f 5g_slice_project/5gc-manifests/free5gc-slice-x1/mongodb/  --recursive -n slice1
sleep 2
kubectl apply -f  5g_slice_project/5gc-manifests/free5gc-slice-x1/networks5g/  --recursive -n slice1
sleep 2
kubectl apply  -f 5g_slice_project/5gc-manifests/free5gc-slice-x1/nf/global/  --recursive -n slice1

for NF in ${NF_LIST5}; do
        kubectl apply  -f 5g_slice_project/5gc-manifests/free5gc-slice-x1/nf/${NF}  --recursive -n slice1
        sleep 7
done
#Manually:
#kubectl apply  -f 5g_slice_project/5gc-manifests/ueransim-gnb-x1/  --recursive -n slice1
#kubectl apply  -f 5g_slice_project/5gc-manifests/ueransim-ue-slice-x1/ue1  --recursive -n slice1
echo done;
