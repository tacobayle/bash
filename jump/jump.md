sudo ufw disable
curl -sfL https://get.k3s.io | sh -
k3s kubectl get node
kubectl get node
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform=v1.0.6
sudo apt-get install terraform=1.0.6
terraform -v
sudo apt install -y python3-pip
sudo apt install -y jq
sudo apt install -y python3-jmespath
pip3 install --upgrade pip
pip3 install ansible==2.10.7