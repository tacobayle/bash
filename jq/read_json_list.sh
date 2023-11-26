#!/bin/bash
list='["10.23.108.1","10.23.108.2","10.16.142.111"]'
echo $list
echo $list | jq -c -r .[] | while read ip ; do echo $ip  ; done

echo "---"

IFS=$'\n'

for item in $(echo $list | jq -c -r .[]) ; do echo $item ; done