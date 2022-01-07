#!/bin/bash
if [ "$#" -ne 3 ]; then
    echo "Illegal number of parameters"
    exit 255
fi
token=$(curl -k -s -X POST -u $2:$3 https://$1/rest/com/vmware/cis/session -H "Content-Type: application/json" | jq .value | tr -d \")
if [[ ${#token} -ne 32 ]] ; then
  echo "Token does not look right"
  exit 255
fi
url="rest/vcenter/datacenter"
raw_dcs=$(curl -k -s -X GET "https://$1/${url}" -H "vmware-api-session-id:${token}" -H "Content-Type: application/json" | jq '.value | map(del(.datacenter)) | map([.name]) | add')
echo $raw_dcs | tee datacenters.json
url="rest/vcenter/cluster"
raw_clusters=$(curl -k -s -X GET "https://$1/${url}" -H "vmware-api-session-id:${token}" -H "Content-Type: application/json" | jq '.value | map(del(.drs_enabled)) | map(del(.cluster)) | map(del(.ha_enabled)) | map([.name]) | add')
echo $raw_clusters | tee clusters.json
url="rest/vcenter/datastore"
raw_datastore=$(curl -k -s -X GET "https://$1/${url}" -H "vmware-api-session-id:${token}" -H "Content-Type: application/json" | jq '.value | map(del(.datastore)) | map(del(.free_space)) | map(del(.capacity)) | map(del(.type)) | map([.name]) | add')
echo $raw_datastore | tee datastores.json
url="rest/vcenter/network"
raw_networks=$(curl -k -s -X GET "https://$1/${url}" -H "vmware-api-session-id:${token}" -H "Content-Type: application/json" | jq '.value | map(del(.network)) | map(del(.type)) | map([.name]) | add')
echo $raw_networks | tee networks.json