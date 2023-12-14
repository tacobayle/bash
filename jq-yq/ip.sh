function test_if_variable_is_valid_ip () {
  # $1 is variable to check
  # $2 indentation message
  echo "$2+++ testing if $1 is a valid IP"
  local  ip=$1
  local  stat=1
  if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    OIFS=$IFS
    IFS='.'
    ip=($ip)
    IFS=$OIFS
    [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
        && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
    stat=$?
  fi
  if [[ $stat -ne 0 ]] ; then echo "$2$1 does not seem to be an IP" ; exit 255 ; fi
}