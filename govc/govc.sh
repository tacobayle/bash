govc library.deploy /library_name/ovf_template vm_name
govc library.export /library_name/ovf_template/*.ovf # save local copy of .ovf
govc import.spec ubuntu.ova | jq .
govc import.spec *.ovf > deploy.json # generate options from .ovf
# edit deploy.json as needed
govc library.deploy -options deploy.json /library_name/ovf_template