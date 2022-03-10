#!/bin/bash
iface="test-iface"
wget -O /tmp/flannel.yml https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml
splitted_file="splitted_flannel" ; rm -f $splitted_file*
final_flannel_file="flannel_modified.yml" ; rm -f $final_flannel_file
#
# removing comments in yaml file
#
cat /tmp/flannel.yml | grep -vE '^\s*(#)' | tee /tmp/flannel_wo_comment.yaml > /dev/null
#
# splitting multiple documents from one yaml file to several yaml files
#
awk '{f="'$splitted_file'" NR; print $0 > f}' RS='---' /tmp/flannel_wo_comment.yaml ; rm splitted_flannel1
#
# adding "---" at the begining of a yaml file
#
for file in $(ls $splitted_file*) ; do sed -i '/^$/d' $file ; sed -i -e "1i ---" $file ; done
#
# searching for a specific kind in a yaml file and adding a specific parameter
#
for file in $(ls $splitted_file*) ; do if [[ $(yq '.kind' $file) == "DaemonSet" ]] ; then echo "modifying file $file" ; yq '.spec.template.spec.containers[0].args += "--iface='$iface'"' $file | tee $file.tmp > /dev/null   mv $file.tmp $file ; fi ; done
#
# merging multiple yaml files in one unique file
#
for file in $(ls $splitted_file*) ; do more $file | tee -a $final_flannel_file > /dev/null ; done