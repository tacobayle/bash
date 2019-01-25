echo | openssl s_client -showcerts -servername 200.1.1.11 -connect gnupg.org:443 2>/dev/null | openssl x509 -inform pem -noout -text
