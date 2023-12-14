#!/bin/bash
IFS=$'\n'
list1='["10.23.108.1","test1","password1"]'
list2='["10.23.108.2","test2","password2"]'
echo $list1 | jq -c -r .
lists="[]"
lists=$(echo "[]" | jq '. += '$(echo $list1 | jq -c -r .)'')
lists=$(echo $lists | jq '. += '$(echo $list2 | jq -c -r .)'')
echo $lists | jq .
for (( index=0; index<$(echo $lists | jq '. | length'); index+=3 )); do
  echo $lists | jq -c -r .[$index]
  echo $lists | jq -c -r .[$((index+1))]
  echo $lists | jq -c -r .[$((index+2))]
  echo "--"
done