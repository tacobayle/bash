#!/bin/bash
list='["10.23.108.1","10.23.108.2","10.16.142.111"]'
echo $list
echo $list | jq -c -r .[] | while read ip ; do echo $ip  ; done

echo "---"

IFS=$'\n'

for item in $(echo $list | jq -c -r .[]) ; do echo $item ; done

file_json_output=transport-nodes-state.json
for edge in $(seq 0 $(($(jq -c -r '.results | length' ${file_json_output})-1)))
do
  echo $edge
  echo $(jq -c -r '.results['$edge'].transport_node_id' ${file_json_output})
  echo $(jq -c -r '.results['$edge'].state' ${file_json_output})
done
