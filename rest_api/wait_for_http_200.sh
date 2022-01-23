while [[ "$(curl -k -s -X GET -b cookies.txt -o /dev/null -w ''%{http_code}'' -H "`grep X-XSRF-TOKEN headers.txt`" -H "Content-Type: application/json" https://$nsx_ip/policy/api/v1/infra/sites/default/enforcement-points/default/host-transport-nodes/$unique_id/state)" != "200" ]]; do
  echo "waiting for transport node status HTTP code to be 200"
  sleep $pause
  ((attempt++))
  if [ $attempt -eq $retry ]; then
    echo "FAILED to get NSX Manager API to be ready after $retry"
    exit 255
  fi
done