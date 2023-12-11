#!/bin/bash
echo "$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 4)$(tr -dc '_:=' </dev/urandom | head -c 1)\
$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 4)$(tr -dc '_:=' </dev/urandom | head -c 1)\
$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 4)"
