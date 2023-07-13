#!/bin/bash
IFS=$'\n'
json_from_file=$(jq -c -r . variables.json)
echo $json_from_file | jq .
json_from_file=$(echo $json_from_file | jq '. += {"unmanaged_k8s_status": false}')
echo $json_from_file | jq .unmanaged_k8s_status

if [[ $(echo $json_from_file | jq -c -r .unmanaged_k8s_status) == true ]]; then
  echo "false"
fi

json_from_file=$(echo $json_from_file | jq '. += {"unmanaged_k8s_status": true}')
echo $json_from_file | jq .unmanaged_k8s_status

if [[ $(echo $json_from_file | jq -c -r .unmanaged_k8s_status) == true ]]; then
  echo "yep"
fi
