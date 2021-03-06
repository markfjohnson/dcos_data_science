#!/usr/bin/env bash
set -x
#
## property is the master ip
HNAME=$(echo $(dcos config show core.dcos_url) | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])')
export HNAME="54.200.25.210"
echo Script name: $0
#echo $# arguments
echo $HNAME
#if [ $# -ne 1 ];
#    then echo "illegal number of parameters...pass the dcos master url"
#el
kubectl config set-cluster dcos-k8s --server=http://localhost:9000
kubectl config set-context dcos-k8s --cluster=dcos-k8s --namespace=default
kubectl config use-context dcos-k8s
echo "configuring ssh tunnel for $HNAME"
dcos kubernetes kubeconfig
#    ssh -4 -f -i ~/dcos_scripts/ccm.pem -N -L 9000:apiserver-insecure.kubernetes.l4lb.thisdcos.directory:9000 core@$HNAME

#fi
kubectl delete deployments --all
kubectl delete service --all
kubectl delete ds --all
kubectl delete serviceaccounts --all
kubectl delete ingress --all
kubectl delete namespace --all
kubectl delete pods --all
#
kubectl create -f k8s-admin-user.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

kubectl create -f config-map.yaml
#kubectl create -f ../wls12_benefits_k8s/install_prmetheus_monitor.yaml --namespace=monitoring
helm install -f values.yaml stable/prometheus
kubectl create -f prometheus.yaml

kubectl create -f traefik.yaml

kubectl create -f ../kubernetes/nginxservice.yaml
kubectl create -f ../kubernetes/benefits_traefik.yaml

### The token for the dashboard
~/dcos_scripts/find_public_node.sh
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
open http://localhost:9000/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

