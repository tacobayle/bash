apt-get update && sudo apt-get -y upgrade
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get -y install docker-ce=18.06.1~ce~3-0~ubuntu

=======

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update

sudo apt-get install -y kubelet=1.12.2-00 kubeadm=1.12.2-00 kubectl=1.12.2-00

sudo apt-mark hold kubelet kubeadm kubectl

=======

kubectl version

=======

Your Kubernetes master has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of machines by running the following on each node
as root:

  kubeadm join 172.31.107.104:6443 --token y1nf6k.aon2or7h3m812ra2 --discovery-token-ca-cert-hash sha256:e80f8e3650fed6c331dca47850ae16b5a6958ca9f8ba1a6c706830e07a8494c2


=======

user@tacobayle1c:~$
user@tacobayle1c:~$ kubectl get nodes
NAME                          STATUS     ROLES    AGE     VERSION
tacobayle1c.mylabserver.com   NotReady   master   3m14s   v1.12.2
tacobayle2c.mylabserver.com   NotReady   <none>   84s     v1.12.2
tacobayle3c.mylabserver.com   NotReady   <none>   70s     v1.12.2
user@tacobayle1c:~$

=======

echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml

ON THE MASTER ONLY:
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml

user@tacobayle1c:~$
user@tacobayle1c:~$ kubectl get nodes
NAME                          STATUS   ROLES    AGE     VERSION
tacobayle1c.mylabserver.com   Ready    master   7m5s    v1.12.2
tacobayle2c.mylabserver.com   Ready    <none>   5m15s   v1.12.2
tacobayle3c.mylabserver.com   Ready    <none>   5m1s    v1.12.2
user@tacobayle1c:~$


user@tacobayle1c:~$
user@tacobayle1c:~$ kubectl get pods -n kube-system
NAME                                                  READY   STATUS    RESTARTS   AGE
coredns-576cbf47c7-9kz97                              1/1     Running   0          7m18s
coredns-576cbf47c7-pzx5h                              1/1     Running   0          7m18s
etcd-tacobayle1c.mylabserver.com                      1/1     Running   0          6m33s
kube-apiserver-tacobayle1c.mylabserver.com            1/1     Running   0          6m36s
kube-controller-manager-tacobayle1c.mylabserver.com   1/1     Running   0          6m18s
kube-flannel-ds-amd64-4mjzd                           1/1     Running   0          62s
kube-flannel-ds-amd64-9nb4b                           1/1     Running   0          62s
kube-flannel-ds-amd64-t7zvv                           1/1     Running   0          62s
kube-proxy-6vxhz                                      1/1     Running   0          5m33s
kube-proxy-xmzcw                                      1/1     Running   0          7m18s
kube-proxy-zdbk5                                      1/1     Running   0          5m47s
kube-scheduler-tacobayle1c.mylabserver.com            1/1     Running   0          6m36s
user@tacobayle1c:~$


=======
