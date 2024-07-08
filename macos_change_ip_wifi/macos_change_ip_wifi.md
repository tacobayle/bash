to change the ip:
```shell
networksetup -setmanual Wi-Fi 172.20.10.3 255.255.255.240 172.20.10.1
```

to revert back:
```shell
networksetup -setdhcp Wi-Fi
```
