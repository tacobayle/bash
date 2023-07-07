#!/bin/bash
max_retry=5 ; counter=0; host www.google.com ; while [ $? -ne 0 ] ; do sleep 2 ; [[ counter -eq $max_retry ]] && echo "DNS Resolution Failed!" && exit 1 ; ((counter++)) ; host www.google.com; done
