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
raw_dcs=$(curl -k -s -X GET "https://$1/${url}" -H "vmware-api-session-id:${token}" -H "Content-Type: application/json" | jq '.value | map(del(.datacenter))')
echo $raw_dcs