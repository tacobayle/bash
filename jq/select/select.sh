#!/bin/bash
#
IFS=$'\n'
#
jsonFile="variables.json"
#
cluster_count=1
for cluster in $(jq -c -r .tkg.clusters.workloads[] $jsonFile)
do
  service_engine_group_name=$(echo $cluster | jq -c -r .name)
  vrf_count=1
  for vrf in $(jq -c -r .avi.config.cloud.contexts[0].routing_options[] $jsonFile)
  do
    echo $vrf_count
    echo $vrf
    networkName="nsx-external-pg"
    peer_bgp_label=$(echo $vrf | jq -c -r .label)
    echo $peer_bgp_label
    vip_network_cidr=$(jq -r --arg network_name "${networkName}" '.avi.config.cloud.additional_subnets[] | select(.name_ref == $network_name)' $jsonFile | jq -r --arg vrf_name "${peer_bgp_label}" '.subnets[] | select(.bgp_label == $vrf_name).cidr')
    echo ${vip_network_cidr}
read -r -d '' yaml_data << EOM
apiVersion: ako.vmware.com/v1alpha1
kind: AviInfraSetting
metadata:
  name: infra-setting-${vrf_count}
spec:
  seGroup:
    name: ${service_engine_group_name}
  network:
    vipNetworks:
      - networkName: ${networkName}
        cidr: ${vip_network_cidr}
    enableRhi: true
    bgpPeerLabels:
      - ${peer_bgp_label}
  l7Settings:
    shardSize: MEDIUM
EOM
    echo "$yaml_data" | tee -a infra-setting-cluster-${cluster_count}-vrf-${vrf_count}.yml > /dev/null
    ((vrf_count++))
  done
  ((cluster_count++))
done