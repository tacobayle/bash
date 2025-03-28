#!/bin/bash
#
if [ -f "../variables.json" ]; then
  jsonFile="../variables.json"
else
  exit 1
fi
nsx_ip=$(jq -r .vcenter.dvs.portgroup.management.nsx_ip $jsonFile)
vcenter_username=administrator
vcenter_domain=$(jq -r .vcenter.sso.domain_name $jsonFile)
vcenter_fqdn="$(jq -r .vcenter.name $jsonFile).$(jq -r .dns.domain $jsonFile)"

curl -k -c cookies.txt -D headers.txt -X POST -d 'j_username=admin&j_password='$TF_VAR_nsx_password'' https://$nsx_ip/api/session/create
ValidCmThumbPrint=$(curl -k -s -X POST -b cookies.txt -H "`grep X-XSRF-TOKEN headers.txt`" -H "Content-Type: application/json" -d '{"server": "'$vcenter_fqdn'", "create_service_account": true, "access_level_for_oidc": "FULL", "origin_type": "vCenter", "set_as_oidc_provider" : true, "credential": {"credential_type": "UsernamePasswordLoginCredential", "username": "'$vcenter_username'@'$vcenter_domain'", "password": "'$TF_VAR_vcenter_password'"}}' https://$nsx_ip/api/v1/fabric/compute-managers | jq -r .error_data.ValidCmThumbPrint)
curl -k -s -X POST -b cookies.txt -H "`grep X-XSRF-TOKEN headers.txt`" -H "Content-Type: application/json" -d '{"server": "'$vcenter_fqdn'", "create_service_account": true, "access_level_for_oidc": "FULL", "origin_type": "vCenter", "set_as_oidc_provider" : true, "credential": {"credential_type": "UsernamePasswordLoginCredential", "username": "'$vcenter_username'@'$vcenter_domain'", "password": "'$TF_VAR_vcenter_password'", "thumbprint": "'$ValidCmThumbPrint'"}}' https://$nsx_ip/api/v1/fabric/compute-managers