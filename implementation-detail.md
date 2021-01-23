## 3 tier web architecture deployed in k8s(KIND)

### (prerequisite)Set Up KIND
* [Download KIND](https://github.com/kubernetes-sigs/kind/releases/download/v0.10.0/kind-linux-amd64)

* [Install Kubectl](https://github.com/kubernetes-sigs/kind/releases/download/v0.10.0/kind-linux-amd64)

* [Install Helm](https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3)

* Run follwoing command to create Kubernetes local envirnment 
```
$ kind create cluster --config kind/kind-config.yaml
```
* Install Cilium CNI
```
$ helm repo add cilium https://helm.cilium.io/


$ helm install cilium cilium/cilium \
    --namespace=kube-system \
    --set ipam.mode=kubernetes \
    --set hubble.metrics.enabled="{dns,drop,tcp,flow,icmp,http}" \
    --set operator.replicas=1
```
### Local Devlopment 
```
kubectl apply -f auth/manifest/auth-deploy.yaml
kubectl apply -f web/manifest/web-deploy.yaml
```
### Network Policy
```
Kubectl apply -f netpol/default-deny.yaml 
kubectl apply -f netpol/allow-web-ingress-egress.yaml
Note: This will only allow web pod HTTPS access. All other external access will be denied using cilium clusterwide netpol
```
### Make file build docker image
```
make build-auth
make build-web
```
### Anti-pattern
I have taken a shortcut route for DB. I have installed the sqlite as sidecar container. Ideally it should be managed service in cloud provider and have network policy to open ingress/egress traffic to particular of the db from the api endpoint

### Improvement
* Multi stage dockerfile
* For local developement and hot reload use [skaffold](https://github.com/GoogleContainerTools/skaffold) or [tilt](https://github.com/tilt-dev/tilt)
* For production grade CD use [argo-cd](https://github.com/argoproj/argo-cd)
* For production grade Kubernetes deployment using kubeadm to create cluster
* For pod level auto-scaling use [KEDA](https://github.com/kedacore/keda)
* For node auto-scaler use [cluster autoscaler](https://github.com/kubernetes/autoscaler)




