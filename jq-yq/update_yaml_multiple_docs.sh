#!/bin/bash
yamlFile=$1
yq  '.' $yamlFile
password=$(echo "$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 4)$(tr -dc '_:=' </dev/urandom | head -c 1)\
$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 4)$(tr -dc '_:=' </dev/urandom | head -c 1)\
$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 4)")
json_data=$(yq  '.' secrets-vsphere-nsx-alb.yml | jq -s -c -r)
mv ${yamlFile} ${yamlFile}.old
json_data=$(echo $json_data | jq '.[1].stringData += {"password": "'${password}'"}')
json_data=$(echo $json_data | jq '.[2].stringData += {"password": "'${password}'"}')
json_data=$(echo $json_data | jq '.[3].stringData += {"password": "'${password}'"}')
json_data=$(echo $json_data | jq '.[4].stringData += {"password": "'${password}'"}')
json_data=$(echo $json_data | jq '.[5].stringData += {"password": "'${password}'"}')
json_data=$(echo $json_data | jq '.[7].stringData += {"password": "'${password}'"}')
touch $yamlFile
echo $json_data | jq -c -r .[] | while read doc
do
  echo $doc | yq -y . | tee -a ${yamlFile}.tmp 2>&1 /dev/null
  echo "---" | tee -a ${yamlFile}.tmp 2>&1 /dev/null
done
head -n -1 ${yamlFile}.tmp | tee ${yamlFile} 2>&1 /dev/null
rm ${yamlFile}.tmp