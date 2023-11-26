#!/bin/bash
i=1
word="dog"
sed -e "s/\${i}/${i}/" \
    -e "s/\${word}/${word}/" \
    -e "s/\${date}/$(date)/" \
    template.txt.template | tee template.txt > /dev/null