# KinD Cluster Configurations

kind is an utility for running Kubernetes clusters locally using Docker containers as "nodes." type was created to test Kubernetes, but it can also be used for local development and continuous integration.
kind is a Kubernetes SIGs project that is significantly distinct from minikube. As the name implies, it partitions the cluster into Docker containers. When compared to starting a VM, this results in a much quicker startup speed. The process of creating a cluster is quite similar to that of minikube.
Pre-requisites -
CentOs7 VM with go, docker and kubectl installed 
## Install docker on CentOS7 
```
[root@node1 ~]# yum -y install epel-release ; yum -y install docker ; systemctl enable --now docker ;systemctl status docker

[root@node1 ~]# docker version
```

## Install kubectl: 

```
[root@node1 ~]# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl

[root@node1 ~]# chmod +x kubectl
[root@node1 ~]# mv ./kubectl /usr/local/bin/kubectl
[root@node1 ~]# kubectl version --client"
```
## Install kind:

```
[root@node1 ~]# curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64

[root@node1 ~]# chmod +x ./kind
[root@node1 ~]# mv ./kind /usr/local/bin
[root@node1 ~]# which kind
/usr/local/bin/kind

[root@node1 ~]# kind version
kind v0.11.1 go1.16.4 linux/amd64
[root@node1 ~]#
```

To communicate with cluster, just give the cluster name as a context in kubectl:

```
[root@node1 ~]# kind create cluster --name k8s-kind-cluster1

Creating cluster "k8s-kind-cluster1" ...
 ✓ Ensuring node image (kindest/node:v1.21.1) 🖼
 ✓ Preparing nodes 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾

Set kubectl context to "kind-k8s-kind-cluster1"

You can now use your cluster with:
kubectl cluster-info --context kind-k8s-kind-cluster1

Have a nice day! 👋
```

## Get the cluster details:

```
[root@node1 ~]# kubectl cluster-info --context kind-k8s-kind-cluster1
Kubernetes control plane is running at https://127.0.0.1:38646
CoreDNS is running at https://127.0.0.1:38646/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

[root@node1 ~]# kubectl get all
NAME         TYPE    CLUSTER-IP  EXTERNAL-IP  PORT(S)  AGE
service/kubernetes  ClusterIP  10.96.0.1  <none>    443/TCP  5m25s

[root@node1 ~]# kubectl get nodes
NAME               STATUS  ROLES         AGE   VERSION
k8s-kind-cluster1-control-plane  Ready  control-plane,master  5m26s  v1.21.11
```
