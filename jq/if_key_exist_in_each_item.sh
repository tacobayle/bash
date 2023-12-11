#!/bin/bash
jsonFile=data/vsphere_nsx_tanzu_alb.json
#jq -c -r '.tanzu.namespaces[].name' $jsonFile
if $(jq -e '.tanzu.namespaces[].name' $jsonFile > /dev/null) ; then
  echo "OK"
else
  echo "NOK"
fi


IFS=$'\n'

        for ns in $(jq -c -r '.tanzu.namespaces[]' $jsonFile)
        do
          if $(echo $ns | jq -e '.namespace_cidr' > /dev/null) || \
             $(echo $ns | jq -e '.namespace_tier0' > /dev/null) || \
             $(echo $ns | jq -e '.prefix_per_namespace' > /dev/null) || \
             $(echo $ns | jq -e '.ingress_cidr' > /dev/null) ; then
            if $(echo $ns | jq -e '.namespace_cidr' > /dev/null) && \
               $(echo $ns | jq -e '.namespace_tier0' > /dev/null) && \
               $(echo $ns | jq -e '.prefix_per_namespace' > /dev/null) && \
               $(echo $ns | jq -e '.ingress_cidr' > /dev/null) ; then
              if [[ $(echo $ns | jq -c -r '.namespace_cidr') != $(jq -c -r '.tanzu.supervisor_cluster.namespace_cidr' $jsonFile) && \
                    $(echo $ns | jq -c -r '.ingress_cidr') != $(jq -c -r '.tanzu.supervisor_cluster.ingress_cidr' $jsonFile) ]] ; then
                echo "   +++ .tanzu.namespaces called $(echo $ns | jq -c -r '.name') has different values for .namespace_cidr and .ingress_cidr than the supervisor clusters"
              else
                echo "   +++ ERROR .tanzu.namespaces called $(echo $ns | jq -c -r '.name') has same values for .namespace_cidr or/and .ingress_cidr than the supervisor clusters"
              fi
            else
              echo "   +++ ERROR .tanzu.namespaces[] should have .namespace_cidr, .namespace_tier0, .prefix_per_namespace, .ingress_cidr - all of them or none of them"
            fi
          fi
          echo "---"
        done

#if $(jq -e '.tanzu.namespaces[].namespace_cidr' $jsonFile > /dev/null) ; then
#  echo "namespace_cidr"
#else
#  echo "NOK"
#fi

#"namespace_cidr": "100.100.66.0/23",
#"namespace_tier0": "my-tier0",
#"prefix_per_namespace": "26",
#"ingress_cidr": "100.100.134.0/24"