#!/bin/bash
jsonFile=data/vsphere_nsx_tanzu_alb.json
#jq '.tanzu.supervisor_cluster.management_tanzu_segment' $jsonFile
#jq '.nsx.config.segments_overlay[]' $jsonFile

test_if_variable_is_defined () {
  # $1 variable to check
  # $2 indentation message
  # $3 test detail message
  echo "$2+++ $3"
  if [[ $1 == "null" || $1 == '""' ]]; then
    exit 255
  fi
}

jq -c -r --arg segment "$(jq -c -r '.tanzu.supervisor_cluster.management_tanzu_segment' $jsonFile)" '.nsx.config.segments_overlay[] | select( .display_name == $segment )' $jsonFile
echo""


      if $(jq -e -c -r --arg segment "$(jq -c -r '.tanzu.supervisor_cluster.management_tanzu_segment' $jsonFile)" '.nsx.config.segments_overlay[] | select( .display_name == $segment )' $jsonFile > /dev/null) ; then
        echo "   +++ .tanzu.supervisor_cluster.management_tanzu_segment ref found"
        test_if_variable_is_defined $(jq -c -r --arg segment "$(jq -c -r '.tanzu.supervisor_cluster.management_tanzu_segment' $jsonFile)" '.nsx.config.segments_overlay[] | select( .display_name == $segment) | .tanzu_supervisor_starting_ip' $jsonFile) "   +++" "testing if $(jq -c -r '.tanzu.supervisor_cluster.management_tanzu_segment' $jsonFile) have tanzu_supervisor_starting_ip defined"
        test_if_variable_is_defined $(jq -c -r --arg segment "$(jq -c -r '.tanzu.supervisor_cluster.management_tanzu_segment' $jsonFile)" '.nsx.config.segments_overlay[] | select( .display_name == $segment) | .tanzu_supervisor_count' $jsonFile) "   +++" "testing if $(jq -c -r '.tanzu.supervisor_cluster.management_tanzu_segment' $jsonFile) have tanzu_supervisor_count defined"

      else
        echo "   +++ .tanzu.supervisor_cluster.management_tanzu_segment ref not found in .nsx.config.segments_overlay[]"
        exit 255
      fi
      if $(jq -e -c -r --arg edge_cluster "$(jq -c -r '.tanzu.supervisor_cluster.namespace_edge_cluster' $jsonFile)" '.nsx.config.edge_clusters[] | select( .display_name == $edge_cluster )' $jsonFile > /dev/null) ; then
        echo "   +++ .tanzu.supervisor_cluster.namespace_edge_cluster ref found"
      else
        echo "   +++ .tanzu.supervisor_cluster.management_tanzu_segment ref not found in .nsx.config.edge_clusters[]"
        exit 255
      fi
      if $(jq -e -c -r --arg tier0 "$(jq -c -r '.tanzu.supervisor_cluster.namespace_tier0' $jsonFile)" '.nsx.config.tier0s[] | select( .display_name == $tier0 )' $jsonFile > /dev/null) ; then
        echo "   +++ .tanzu.supervisor_cluster.namespace_tier0 ref found"
      else
        echo "   +++ .tanzu.supervisor_cluster.namespace_tier0 ref not found in .nsx.config.tier0s[]"
        exit 255
      fi