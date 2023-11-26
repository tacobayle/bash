#!/bin/bash
i=1
word="dog"
sed -e "s/\${i}/${i}/" -e "s/\${word}/${word}/" template.txt.template | tee template.txt > /dev/null