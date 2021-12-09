#!/bin/bash
echo "one" | tee test.txt
echo "two" | tee -a test.txt
echo "tree" | tee -a test.txt
echo "four" | tee -a test.txt
echo "----"
cat test.txt
echo "----"
sed -i -e 's/four/"21.1.2"/g' test.txt
cat test.txt
