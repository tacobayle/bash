ifPrimary=`ip route | grep default | sed -e "s/^.*dev.//" -e "s/.proto.*//"`
ip=$(ifconfig $ifPrimary | grep 'inet addr' | awk -F: '{print $2}' | awk '{print $1}')
