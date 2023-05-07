function test_if_variable_is_valid_cidr () {
  # $1 is variable to check
  # $2 indentation message
  local  ip=$(echo $1 | cut -d"/" -f1)
  local  prefix=$(echo $1 | cut -d"/" -f2)
  local  stat=1
  local  test_prefix=1
  if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    OIFS=$IFS
    IFS='.'
    ip=($ip)
    IFS=$OIFS
    [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
        && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
    stat=$?
  fi
  if [[ $prefix -ge 2 && $prefix -le 32 ]]; then test_prefix=0 ; fi
  if [[ $stat -ne 0 || $test_prefix -ne 0 ]] ; then echo "$2$1 does not seem to be a valid CIDR" ; exit 255 ; fi
}

test_if_variable_is_valid_cidr "10.1.1.0/26"
test_if_variable_is_valid_cidr "25.1.1.0/3"

