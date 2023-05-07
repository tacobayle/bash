#!/bin/bash

function valid_ip()
{
local  ip=$1
local  stat=1
if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    OIFS=$IFS
    IFS='.'
    ip=($ip)
    IFS=$OIFS
    [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
        && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
    stat=$?
fi
if [[ $stat -ne 0 ]] ; then echo "$1 does not seem to be an IP" ; exit 255 ; fi
}
valid_ip "1.2.3.4"
valid_ip  $(echo 100.100.100.0/24 | cut -d"/" -f1)
valid_ip "256.2.3.4"
