cidr=$(jq -c -r .spec.networks[0].cidr /root/nic-vsphere.json | cut -d"/" -f1)
pod-vsphere:/# echo ${cidr}
172.16.10.0
pod-vsphere:/#
pod-vsphere:/# if [[ $cidr =~ ^([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.[0-9]{1,3}$ ]] ; then echo "${BASH_REMATCH[1]}.${BASH_REMATCH[2]}.${BASH_REMATCH[3]}" ; fi
172.16.10
pod-vsphere:/#