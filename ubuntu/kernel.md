```
apt update
apt list linux-*image-*
```

```
# grub list of kernel available
sudo grub-mkconfig | grep -iE "menuentry 'Ubuntu, with Linux" | awk '{print i++ " : "$1, $2, $3, $4, $5, $6, $7}'
```

```
#kernel downgrade
DEBIAN_FRONTEND=noninteractive apt install --assume-yes linux-image-4.4.0-21-generic
sed -i -e "s/GRUB_DEFAULT=0/GRUB_DEFAULT=\"1>2\"/g" /etc/default/grub
update-grub
```