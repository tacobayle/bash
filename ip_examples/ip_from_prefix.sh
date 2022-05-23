echo $(echo 100.100.100.0/24 | cut -d"/" -f1 | cut -d"." -f1-3).11


#nic@jump:~$ echo $(echo 100.100.100.0/24 | cut -d"/" -f1 | cut -d"." -f1-3).11
#100.100.100.11
#nic@jump:~$
