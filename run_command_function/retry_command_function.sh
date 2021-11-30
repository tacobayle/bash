#!/bin/bash
run_cmd() {
  retry=6
  pause=5
  attempt=0
  echo "############################################################################################"
  while [ $attempt -ne $retry ]; do
    if eval "$@"; then
      echo "$1 PASSED"	    
      break
    else
      echo "$1 FAILED"
    fi
    ((attempt++))
    sleep $pause
  done
}
run_cmd 'wget https://packages.cloud.google.com/apt/doc/apt-key.gpg'
run_cmd 'sudo apt-key add apt-key.gpg'
run_cmd 'wget https://baltocdn.com/helm/signing.asc'
run_cmd 'sudo apt-key add signing.asc'
run_cmd 'wget https://download.docker.com/linux/ubuntu/gpg'
run_cmd 'sudo apt-key add gpg'
run_cmd 'sudo add-apt-repository "deb https://apt.kubernetes.io/ kubernetes-xenial main"'
run_cmd 'sudo add-apt-repository "deb https://baltocdn.com/helm/stable/debian/ all main"'
run_cmd 'sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"'
