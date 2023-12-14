CANAME=MyOrg-RootCA
# optional, create a directory
mkdir $CANAME
cd $CANAME
# generate aes encrypted private key
openssl genrsa -aes256 -out $CANAME.key 4096
# create certificate, 1826 days = 5 years
openssl req -x509 -new -nodes -key $CANAME.key -sha256 -days 1826 -out $CANAME.crt -subj '/CN=My Root CA/C=AT/ST=Vienna/L=Vienna/O=MyOrganisation'
# create certificate for service
MYCERT=myserver.local
openssl req -new -nodes -out $MYCERT.csr -newkey rsa:4096 -keyout $MYCERT.key -subj '/CN=My Firewall/C=AT/ST=Vienna/L=Vienna/O=MyOrganisation'
# create a v3 ext file for SAN properties
cat > $MYCERT.v3.ext << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = myserver.local
DNS.2 = myserver1.local
IP.1 = 192.168.1.1
IP.2 = 192.168.2.1
EOF
openssl x509 -req -in $MYCERT.csr -CA $CANAME.crt -CAkey $CANAME.key -CAcreateserial -out $MYCERT.crt -days 730 -sha256 -extfile $MYCERT.v3.ext