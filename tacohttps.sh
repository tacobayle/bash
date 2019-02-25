# to be added in .profile

function tacohttps () {
  while true; do curl -k https://$1/custom/ ; sleep $2 ; echo "" ; done
}
