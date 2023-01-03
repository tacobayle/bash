nextip(){
    IFS=$' \t\n'
    IP=$1
    IP_HEX=$(printf '%.2X%.2X%.2X%.2X\n' `echo $IP | sed -e 's/\./ /g'`)
    NEXT_IP_HEX=$(printf %.8X `echo $(( 0x$IP_HEX + 1 ))`)
    NEXT_IP=$(printf '%d.%d.%d.%d\n' `echo $NEXT_IP_HEX | sed -r 's/(..)/0x\1 /g'`)
    echo "$NEXT_IP"
    IFS=$'\n'
}

FIRST_IP=192.168.1.250
NUM=10

IP=$FIRST_IP
for i in $(seq 1 $NUM); do
    echo $IP
    IP=$(nextip $IP)
done