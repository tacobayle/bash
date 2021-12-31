#!/bin/bash
if [ "$#" -ne 4 ]; then
    echo "Illegal number of parameters"
    exit 255
fi
token=$(curl -k -s -X POST -u $2:$3 https://$1/rest/com/vmware/cis/session -H "Content-Type: application/json" | jq .value | tr -d \")
if [[ ${#token} -ne 32 ]] ; then
  echo "Token does not look right"
  exit 255
fi
if [[ $4 == "datacenters" ]] ; then
  url="rest/vcenter/datacenter"
  raw_dcs=$(curl -k -s -X GET "https://$1/${url}" -H "vmware-api-session-id:${token}" -H "Content-Type: application/json" | jq '.value | map(del(.datacenter))')
  echo $raw_dcs
elif [[ $4 == "clusters" ]] ; then
  url="rest/vcenter/cluster"
  raw_clusters=$(curl -k -s -X GET "https://$1/${url}" -H "vmware-api-session-id:${token}" -H "Content-Type: application/json" | jq '.value | map(del(.drs_enabled)) | map(del(.cluster)) | map(del(.ha_enabled))')
  echo $raw_clusters
elif [[ $4 == "datastores" ]] ; then
  url="rest/vcenter/datastore"
  raw_clusters=$(curl -k -s -X GET "https://$1/${url}" -H "vmware-api-session-id:${token}" -H "Content-Type: application/json" | jq '.value | map(del(.datastore)) | map(del(.free_space)) | map(del(.capacity)) | map(del(.type))')
  echo $raw_clusters
elif [[ $4 == "networks" ]] ; then
  url="rest/vcenter/network"
  raw_networks=$(curl -k -s -X GET "https://$1/${url}" -H "vmware-api-session-id:${token}" -H "Content-Type: application/json" | jq '.value | map(del(.network)) | map(del(.type))')
  echo $raw_networks
else
  echo 'Illegal parameter: $4 should be equal to one of the following: datacenters, clusters, datastores, networks'
  exit 255
fi