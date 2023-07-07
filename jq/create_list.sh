#!/bin/bash
test="{\"host_switch_spec\" : {\"host_switches\" : []}}"
IFS=$'\n'
for host_switche in $(jq -c -r .nsx.config.edge_node.host_switch_spec.host_switches[] variables.json)
do
  IFS=$'\n'
  echo $(echo $host_switche | jq -r .host_switch_name)
  echo $(echo $host_switche | jq -r .pnics)
  test=$(echo $test | jq '.host_switch_spec.host_switches += [{"host_switch_name": "'$(echo $host_switche | jq -r .host_switch_name)'", "host_switch_type": "'$(echo $host_switche | jq -r .host_switch_type)'", "host_switch_mode": "'$(echo $host_switche | jq -r .host_switch_mode)'", "host_switch_mode": "'$(echo $host_switche | jq -r .host_switch_mode)'", "pnics": "'$(echo $host_switche | jq -r -c .pnics)'"}]')

done
#test=$(echo $test | jq '.test_list += [{"item1": "abc"}]')
#test=$(echo $test | jq '.test_list += [{"item2": "def"}]')
echo $test | jq .