#!/bin/bash

LABPASS="VMware1!"

# Function for executing commands on a remote server
execute_on_server() {
  server=$1
  command=$2
  ssh aviadmin@$server "$command"
  pid=$!                  # Store the background process ID
  wait $pid               # Wait for the background process to complete1
  }
	  
	  # Server addresses 
	  MASTER_SERVER="sa-server-01"
	  NODE01_SERVER="sa-server-02"
	  NODE02_SERVER="sa-server-03"
	  
	  # Reset and Init on the Master Serverecho "**Performing reset and init on the master ($MASTER_SERVER)...**"
	  execute_on_server "$MASTER_SERVER" "echo $LABPASS | sudo -S kubeadm  reset -f "
	  
	  init_output=$(execute_on_server "$MASTER_SERVER" "echo $LABPASS | sudo -S kubeadm  init --pod-network-cidr=10.244.0.0/16")
	  join_command=$(echo "$init_output" | tail -2)
	  # join_command=$(echo "$init_output" | grep -o 'kubeadm join .*' )
	  
	  # Error checking
	  if [ -z "$join_command" ]; then
	    echo "Error: Failed to extract kubeadm join command."
		  exit 1
		  fi
		  
		  echo "**Kubeadm join command:**"
		  echo "$join_command"
		  
		  # Configure kube config
		  execute_on_server "$MASTER_SERVER" "rm -rf .kube/*;"
		  execute_on_server "$MASTER_SERVER" "echo $LABPASS | sudo -S  cp /etc/kubernetes/admin.conf .kube/config;"
		  execute_on_server "$MASTER_SERVER" "echo $LABPASS | sudo -S  chown $(id -u):$(id -g) .kube/config"
		  
		  # Reset and Join Nodes
		  echo "**Performing reset and join on node 01 ($NODE01_SERVER)...**"
		  execute_on_server "$NODE01_SERVER" "echo $LABPASS | sudo  -S kubeadm reset -f"
		  execute_on_server "$NODE01_SERVER" "echo $LABPASS | sudo  -S $join_command"
		  
		  echo "**Performing reset and join on node 02 ($NODE02_SERVER)...**"
		  execute_on_server "$NODE02_SERVER" "echo $LABPASS | sudo -S kubeadm  reset -f"
		  execute_on_server "$NODE02_SERVER" "echo $LABPASS | sudo -S $join_command"
		  
		  # Check Node Status on Masterecho "**Checking node status on master ($MASTER_SERVER)...**"
		  execute_on_server "$MASTER_SERVER" "kubectl get nodes"
		  
		  # Antrea Deployment
		  echo "**Deploying Antrea...**"
		  execute_on_server "$MASTER_SERVER" "kubectl apply -f https://github.com/antrea-io/antrea/releases/download/v1.5.0/antrea.yml"
		  
		  
		  # Application Deploymentyyecho "**Deploying applications...**"
		  execute_on_server "$MASTER_SERVER" "cd ~/apps; kubectl apply -f juice.yaml; kubectl apply -f kuard.yaml; kubectl apply -f hackazon.yaml; kubectl apply -f dvwa.yaml; kubectl apply -f avinetworks.yaml" 
		 
		 
		   # Application Deployment echo "**Check applications...**"
		  execute_on_server "$MASTER_SERVER" "kubectl get deployments"
