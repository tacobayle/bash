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


Create a pod

cat << EOF | kubectl create -f -
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
EOF

user@tacobayle1c:~$
user@tacobayle1c:~$ kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          53s
user@tacobayle1c:~$


user@tacobayle1c:~$ kubectl get pods -n kube-system
NAME                                                  READY   STATUS    RESTARTS   AGE
coredns-576cbf47c7-9kz97                              1/1     Running   0          20m
coredns-576cbf47c7-pzx5h                              1/1     Running   0          20m
etcd-tacobayle1c.mylabserver.com                      1/1     Running   0          19m
kube-apiserver-tacobayle1c.mylabserver.com            1/1     Running   0          19m
kube-controller-manager-tacobayle1c.mylabserver.com   1/1     Running   0          19m
kube-flannel-ds-amd64-4mjzd                           1/1     Running   0          14m
kube-flannel-ds-amd64-9nb4b                           1/1     Running   0          14m
kube-flannel-ds-amd64-t7zvv                           1/1     Running   0          14m
kube-proxy-6vxhz                                      1/1     Running   0          18m
kube-proxy-xmzcw                                      1/1     Running   0          20m
kube-proxy-zdbk5                                      1/1     Running   0          18m
kube-scheduler-tacobayle1c.mylabserver.com            1/1     Running   0          19m
user@tacobayle1c:~$

user@tacobayle1c:~$
user@tacobayle1c:~$ kubectl describe pod nginx
Name:               nginx
Namespace:          default
Priority:           0
PriorityClassName:  <none>
Node:               tacobayle3c.mylabserver.com/172.31.97.226
Start Time:         Mon, 28 Jan 2019 19:16:08 +0000
Labels:             <none>
Annotations:        <none>
Status:             Running
IP:                 10.244.2.2
Containers:
  nginx:
    Container ID:   docker://ffc5c521e31355d427af4fc8e91fc648e90cee9318f4188d1e4b51503008bb86
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:56bcd35e8433343dbae0484ed5b740843dd8bff9479400990f251c13bbb94763
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Mon, 28 Jan 2019 19:16:14 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-2wsqg (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-2wsqg:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-2wsqg
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age    From                                  Message
  ----    ------     ----   ----                                  -------
  Normal  Scheduled  4m1s   default-scheduler                     Successfully assigned default/nginx to tacobayle3c.mylabserver.com
  Normal  Pulling    4m     kubelet, tacobayle3c.mylabserver.com  pulling image "nginx"
  Normal  Pulled     3m56s  kubelet, tacobayle3c.mylabserver.com  Successfully pulled image "nginx"
  Normal  Created    3m55s  kubelet, tacobayle3c.mylabserver.com  Created container
  Normal  Started    3m55s  kubelet, tacobayle3c.mylabserver.com  Started container
user@tacobayle1c:~$


user@tacobayle1c:~$
user@tacobayle1c:~$ kubectl delete pod nginx
pod "nginx" deleted
user@tacobayle1c:~$

=======

Get node detail

kubectl get nodes
kubectl describe node $node_name


user@tacobayle1c:~$
user@tacobayle1c:~$ kubectl get nodes
NAME                          STATUS   ROLES    AGE    VERSION
tacobayle1c.mylabserver.com   Ready    master   133m   v1.12.2
tacobayle2c.mylabserver.com   Ready    <none>   131m   v1.12.2
tacobayle3c.mylabserver.com   Ready    <none>   131m   v1.12.2
user@tacobayle1c:~$ kubectl describe node tacobayle3c.mylabserver.com
Name:               tacobayle3c.mylabserver.com
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/hostname=tacobayle3c.mylabserver.com
Annotations:        flannel.alpha.coreos.com/backend-data: {"VtepMAC":"76:1c:0b:f1:35:cc"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 172.31.97.226
                    kubeadm.alpha.kubernetes.io/cri-socket: /var/run/dockershim.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Mon, 28 Jan 2019 18:58:44 +0000
Taints:             <none>
Unschedulable:      false
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----             ------  -----------------                 ------------------                ------                       -------
  OutOfDisk        False   Mon, 28 Jan 2019 21:10:01 +0000   Mon, 28 Jan 2019 18:58:44 +0000   KubeletHasSufficientDisk     kubelet has sufficient disk space available
  MemoryPressure   False   Mon, 28 Jan 2019 21:10:01 +0000   Mon, 28 Jan 2019 18:58:44 +0000   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure     False   Mon, 28 Jan 2019 21:10:01 +0000   Mon, 28 Jan 2019 18:58:44 +0000   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure      False   Mon, 28 Jan 2019 21:10:01 +0000   Mon, 28 Jan 2019 18:58:44 +0000   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready            True    Mon, 28 Jan 2019 21:10:01 +0000   Mon, 28 Jan 2019 19:03:24 +0000   KubeletReady                 kubelet is posting ready status. AppArmor enabled
Addresses:
  InternalIP:  172.31.97.226
  Hostname:    tacobayle3c.mylabserver.com
Capacity:
 cpu:                2
 ephemeral-storage:  20263484Ki
 hugepages-2Mi:      0
 memory:             4038180Ki
 pods:               110
Allocatable:
 cpu:                2
 ephemeral-storage:  18674826824
 hugepages-2Mi:      0
 memory:             3935780Ki
 pods:               110
System Info:
 Machine ID:                 9ef2866073d1434aa3bdbde3f2f26eb1
 System UUID:                EC219413-860D-5C4C-AD6B-F711D3B0C250
 Boot ID:                    7eeab03b-7ab5-4d4d-86d8-170e94d3d300
 Kernel Version:             4.15.0-1031-aws
 OS Image:                   Ubuntu 18.04.1 LTS
 Operating System:           linux
 Architecture:               amd64
 Container Runtime Version:  docker://18.6.1
 Kubelet Version:            v1.12.2
 Kube-Proxy Version:         v1.12.2
PodCIDR:                     10.244.2.0/24
Non-terminated Pods:         (2 in total)
  Namespace                  Name                           CPU Requests  CPU Limits  Memory Requests  Memory Limits
  ---------                  ----                           ------------  ----------  ---------------  -------------
  kube-system                kube-flannel-ds-amd64-t7zvv    100m (5%)     100m (5%)   50Mi (1%)        50Mi (1%)
  kube-system                kube-proxy-6vxhz               0 (0%)        0 (0%)      0 (0%)           0 (0%)
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource  Requests   Limits
  --------  --------   ------
  cpu       100m (5%)  100m (5%)
  memory    50Mi (1%)  50Mi (1%)
Events:     <none>
user@tacobayle1c:~$

=======

K8S network

cat << EOF | kubectl create -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.15.4
        ports:
        - containerPort: 80
EOF

user@tacobayle1c:~$ kubectl get pods
NAME                   READY   STATUS    RESTARTS   AGE
nginx-d55b94fd-cxr5d   1/1     Running   0          4m18s
nginx-d55b94fd-w2pc4   1/1     Running   0          4m18s

cat << EOF | kubectl create -f -
apiVersion: v1
kind: Pod
metadata:
  name: busybox
spec:
  containers:
  - name: busybox
    image: radial/busyboxplus:curl
    args:
    - sleep
    - "1000"
EOF

user@tacobayle1c:~$ kubectl get pods -o wide
NAME                   READY   STATUS    RESTARTS   AGE     IP           NODE                          NOMINATED NODE
busybox                1/1     Running   0          22s     10.244.2.4   tacobayle3c.mylabserver.com   <none>
nginx-d55b94fd-cxr5d   1/1     Running   0          5m55s   10.244.1.4   tacobayle2c.mylabserver.com   <none>
nginx-d55b94fd-w2pc4   1/1     Running   0          5m55s   10.244.2.3   tacobayle3c.mylabserver.com   <none>
user@tacobayle1c:~$


user@tacobayle1c:~$
user@tacobayle1c:~$ kubectl exec busybox -- curl 10.244.1.4
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   612  100   612    0     0   266k      0 --:--:-- --:--:-- --:--:--  597k
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
user@tacobayle1c:~$

=======

Deployment

cat << EOF | kubectl create -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.15.4
        ports:
        - containerPort: 80
EOF

kubectl get deployments

kubectl describe deployment nginx-deployment

kubectl get pods

user@tacobayle1c:~$ kubectl describe deployment nginx-deployment
Name:                   nginx-deployment
Namespace:              default
CreationTimestamp:      Tue, 29 Jan 2019 10:10:31 +0000
Labels:                 app=nginx
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=nginx
Replicas:               2 desired | 2 updated | 2 total | 2 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=nginx
  Containers:
   nginx:
    Image:        nginx:1.15.4
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   nginx-deployment-d55b94fd (2/2 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  89s   deployment-controller  Scaled up replica set nginx-deployment-d55b94fd to 2
user@tacobayle1c:~$
user@tacobayle1c:~$

=======

Services


cat << EOF | kubectl create -f -
kind: Service
apiVersion: v1
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
    nodePort: 30080
  type: NodePort
EOF

user@tacobayle1c:~$
user@tacobayle1c:~$ kubectl get svc
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP        15h
nginx-service   NodePort    10.100.36.13   <none>        80:30080/TCP   3m27s
user@tacobayle1c:~$

user@tacobayle1c:~$
user@tacobayle1c:~$ kubectl describe services nginx-service
Name:                     nginx-service
Namespace:                default
Labels:                   <none>
Annotations:              <none>
Selector:                 app=nginx
Type:                     NodePort
IP:                       10.100.36.13
Port:                     <unset>  80/TCP
TargetPort:               80/TCP
NodePort:                 <unset>  30080/TCP
Endpoints:                10.244.1.7:80,10.244.1.8:80,10.244.2.6:80 + 1 more...
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
user@tacobayle1c:~$
