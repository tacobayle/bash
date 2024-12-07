#!/bin/bash
#
fqdn=$1
timeout=3
threshold=10
#
cert_info=$(timeout $timeout openssl s_client -connect $fqdn:443 2>/dev/null | openssl x509 -noout -dates)
#
expiration_date=$(echo "$cert_info" | grep 'notAfter' | cut -d= -f2)
expiration_date_readable=$(date -d "$expiration_date" +'%Y-%m-%d')
days_remaining=$((($(date -d "$expiration_date" +%s) - $(date +%s)) / 86400))
if [[ $days_remaining -le $threshold ]]; then
  echo "WARNING: Certificate for $fqdn expires on $expiration_date_readable ($days_remaining days remaining)"
  # You can add actions here, like sending notifications, logging, etc.
else
  echo "Certificate for $fqdn is valid until $expiration_date_readable ($days_remaining days remaining)"
fi
