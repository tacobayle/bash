#!/bin/bash
FILE=/etc/resolv.conf
if [ -f "$FILE" ]; then echo "$FILE exists." ; else echo "$FILE does not exit" ; fi