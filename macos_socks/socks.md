- to create the tunnel
```
SshSocksNestedAlbStart () {
  ssh -f -N -M -S /tmp/sshtunnel -D 1080 ubuntu@10.41.134.170  -p22
}
```

- to destroy the tunnel
```
SshSocksNestedAlbStop () {
  ssh -S /tmp/sshtunnel -O exit ubuntu@10.41.134.170 -p22
}
```
