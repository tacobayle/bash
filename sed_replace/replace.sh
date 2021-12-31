#!/bin/bash
TF_VAR_toto="21.1.2"
echo "one" | tee test.txt
echo "two" | tee -a test.txt
echo "tree" | tee -a test.txt
echo "four" | tee -a test.txt
echo "----"
cat test.txt
echo "----"
sed -i -e "s/four/\"$TF_VAR_toto\"/g" test.txt
cat test.txt
