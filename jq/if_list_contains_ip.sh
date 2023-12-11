#!/bin/bash
jsonFile=data/vsphere_tanzu_alb_wo_nsx.json
source ./lib.sh
alb_networks='["se", "backend", "vip", "tanzu"]'
for network in $(echo $alb_networks | jq -c -r .[])
do
    if [[ $(jq -c -r .vsphere_underlay.networks.alb.$network.app_ips $jsonFile) != "null" ]] ; then

test_if_list_contains_ip "${jsonFile}" ".vsphere_underlay.networks.alb.$network.app_ips[]"
  fi




done


