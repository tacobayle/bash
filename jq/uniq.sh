#!/bin/bash
jsonFile=data/vsphere_nsx_tanzu_alb.json
jq -c -r '.tanzu.tkc_clusters | map(select(.name) | .name)' $jsonFile
#jq -c -r '.tanzu.tkc_clusters[].name' $jsonFile


test_if_list_of_value_is_unique () {
  # $1 is jsonFile
  # $2 is list and key to check like .tanzu.tkc_clusters[].name
  if [[ $(jq -c -r $2 $1 | uniq -d) != "" ]] ; then
    echo "   ERROR $2 is not unique"
    exit 255
  fi
}



test_if_list_of_value_is_unique "${jsonFile}" ".tanzu.tkc_clusters[].name"

#if [[ $(jq -c -r '.tanzu.tkc_clusters[].name' $jsonFile | uniq -d) != "" ]] ; then
#  echo "   ERROR .tanzu.tkc_clusters[].name is not unique"
#  exit 255
#fi