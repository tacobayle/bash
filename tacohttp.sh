# to be added in .profile

function tacohttp () {
  while true; do curl $1/custom/ ; sleep $2 ; echo "" ; done
}
