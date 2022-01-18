#!/bin/bash
assign_var_from_json_file () {
  rm -f .var
  echo "Select $1..."
  if [[ $(jq length $2) -eq 1 ]] ; then
    echo "defaulting to $(jq -r -c .[0] $2)"
    var=$(jq -r -c .[0] $2)
  else
    count=1
    IFS=$'\n'
    for item in $(jq -c -r .[] $2)
    do
      echo "$count: $item"
      count=$((count+1))
    done
    re='^[0-9]+$' ; yournumber=""
    until [[ $yournumber =~ $re ]] ; do echo -n "$1 number: " ; read -r yournumber ; done
    yournumber=$((yournumber-1))
    var=$(jq -r -c .[$yournumber] $2)
  fi
  echo $var | tee .var >/dev/null
  sleep 2
  clear
}
#
assign_var_boolean () {
  unset var
  until [[ $var == "y" ]] || [[ $var == "n" ]] ; do echo -n "$1 y/n?: " ; read -r var ; done
#  echo $var | tee .var >/dev/null
  if [[ $var == "y" ]] ; then
    contents="$(jq '."'$2'" = true' $3)"
  fi
  if [[ $var == "n" ]] ; then
    contents="$(jq '."'$2'" = false' $3)"
  fi
  echo $contents | tee $3 >/dev/null
  sleep 2
  clear
}
rm -f booleans.json ; echo "{}" | tee booleans.json >/dev/null
unset TF_VAR_avi_version ; assign_var_from_json_file "Avi version" "avi_versions.json" ; TF_VAR_avi_version=$(cat .var)
unset TF_VAR_ako_version ; assign_var_from_json_file "AKO version" "ako_versions.json" ; TF_VAR_ako_version=$(cat .var)
assign_var_boolean "dhcp for management network" "dhcp" "booleans.json"
unset deploy_ako ; assign_var_boolean "deploy AKO" "deploy_ako" "booleans.json"

#unset dhcp ; until [[ $dhcp == "y" ]] || [[ $dhcp == "n" ]] ; do echo -n "dhcp for management network y/n: " ; read -r dhcp ; done
#if [[ $dhcp == "y" ]] ; then
#  contents="$(jq '.dhcp = true' booleans.json)"
#  echo $contents | tee booleans.json >/dev/null
#fi
if [[  $(jq -r .dhcp booleans.json) == false ]] ; then
  contents="$(jq '.dhcp = false' booleans.json)"
  echo $contents | tee booleans.json >/dev/null
  unset TF_VAR_vcenter_network_mgmt_network_cidr ; until [ ! -z "$TF_VAR_vcenter_network_mgmt_network_cidr" ] ; do echo -n "enter management network address cidr (like: 10.206.112.0/22): " ;  read -r TF_VAR_vcenter_network_mgmt_network_cidr ; done
fi
echo $TF_VAR_avi_version
echo $TF_VAR_ako_version
echo $TF_VAR_vcenter_network_mgmt_network_cidr

