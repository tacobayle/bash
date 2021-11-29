# install samba
sudo apt-get install samba
# set up an aacount for samba:
sudo smbpasswd -a avi
# avi@ansible:~$ sudo smbpasswd -a avi
# New SMB password:
# Retype new SMB password:
# Added user avi.
# avi@ansible:~$
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.ori
# Add a share in the config file like this:
# [ansible]
# path = /home/avi
# available = yes
# valid users = avi
# read only = no
# browsable = yes
# public = yes
# writable = yes
sudo service smbd restart
