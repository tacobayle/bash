ifPrimary=$(ip route | grep default | sed -e "s/^.*dev.//" -e "s/.proto.*//")
ip=$(ip address show dev $ifPrimary | grep -v inet6 | grep inet | awk '{print $2}')
echo $ip
gw=$(ip route show 0.0.0.0/0 | awk '{print $3}')
echo $gw