#!/bin/bash
#
fqdn=$1
webhook_url=$2
timeout=3
threshold=10
#
# google chat function
#
send_google_chat_message() {
  local url="$1"
  local message="$2"

  if [[ -z "$url" || -z "$message" ]]; then
    echo "Error: Webhook URL or message is missing."
    return 1
  fi

  local payload='{"text":"'$message'"}'

  curl -X POST -H "Content-Type: application/json; charset=UTF-8" -d "$payload" "$url"
}
#
# cert check
#
cert_info=$(timeout $timeout openssl s_client -connect $fqdn:443 2>/dev/null | openssl x509 -noout -dates)
#
expiration_date=$(echo "$cert_info" | grep 'notAfter' | cut -d= -f2)
expiration_date_readable=$(date -d "$expiration_date" +'%Y-%m-%d')
today_date=$(date +'%Y-%m-%d')
days_remaining=$((($(date -d "$expiration_date" +%s) - $(date +%s)) / 86400))
if [[ ${expiration_date_readable} < ${today_date} ]]; then
  message="CRITICAL: ${fqdn}, Certificate is expired since ${expiration_date_readable}"
fi
if [[ $days_remaining -le $threshold ]]; then
  message="WARNING: ${fqdn}, Certificate for $fqdn expires on $expiration_date_readable ($days_remaining days remaining)"
else
  message="INFO: ${fqdn}, Certificate for $fqdn is valid until $expiration_date_readable ($days_remaining days remaining)"
fi
send_google_chat_message "$webhook_url" "$message"