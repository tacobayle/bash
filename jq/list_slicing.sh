#!/bin/bash
echo '[1,2,3,4,5,6,7,8,9,10]' | jq '.[1:]'
echo '[1,2,3,4,5,6,7,8,9,10]' | jq '.[:4]'