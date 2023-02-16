#!/bin/bash
FILE=empty_file
if [ -s "$FILE" ]; then echo "$FILE is not empty." ; else echo "$FILE is empty" ; fi
