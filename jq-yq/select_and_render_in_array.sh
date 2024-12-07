ubuntu@external-gw-20240711110848:~$ jq '.nsx.config.segments_overlay[] | select(has("app_ips")).display_name' app.json
"my-segment-server-1"
"my-segment-migration-vcenter"
"my-segment-server-2"
ubuntu@external-gw-20240711110848:~$
ubuntu@external-gw-20240711110848:~$
ubuntu@external-gw-20240711110848:~$ jq '[.nsx.config.segments_overlay[] | select(has("app_ips")).display_name]' app.json
[
  "my-segment-server-1",
  "my-segment-migration-vcenter",
  "my-segment-server-2"
]
ubuntu@external-gw-20240711110848:~$