#!/bin/bash
run_cmd() {
  retry=3
  pause=1
  attempt=0
  echo "############################################################################################"
  while [ $attempt -ne $retry ]; do
    echo "$1"
    if eval "$@"; then
      echo "$1 PASSED - no stderr code"   
      break
    else
      echo "$1 FAILED"
    fi
    ((attempt++))
    sleep $pause
  done
}
#run_cmd 'wget https://packages.cloud.google.com/apt/doc/apt-key.gpg -O /tmp/apt-key.gpg; ls /tmp/apt-key.gpg'
#run_cmd '! sudo add-apt-repository "deb https://apt.kubernetes.io/ kubernetes-xenial main" | grep Err:'
run_cmd 'wget -O /tmp/calico.yml https://docs.projectcalico.org/manifests/calico.yaml; test $(ls -l /tmp/calico.yml | awk '"'"'{print $5}'"'"') -gt 0'
for image in $(cat /tmp/calico.yml | grep 'image: ' | awk -F 'image: ' '{print $2}'); do image_to_search=$(echo $image | sed -e "s/docker.io\///g" | awk -F':' '{print $1}') ; run_cmd "docker pull $image; docker image ls | grep $image_to_search" ; done
run_cmd 'wget -O /tmp/flannel.yml https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml; test $(ls -l /tmp/flannel.yml | awk '"'"'{print $5}'"'"') -gt 0'
for image in $(cat /tmp/flannel.yml | grep 'image: ' | awk -F 'image: ' '{print $2}'); do image_to_search=$(echo $image | awk -F':' '{print $1}') ; run_cmd "docker pull $image; docker image ls | grep $image_to_search" ; done