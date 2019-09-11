#!/usr/bin/env bash
# create a secret PGPASSWORD

gcloud config set project aerial-mission-252519
gcloud config set compute/zone us-central1-a
gcloud container clusters get-credentials multi-cluster

kubectl create secret generic pgpassword --from-literal PGPASSWORD=changeit

# let helm & tiller take care of ingress config
curl -LO https://git.io/get_helm.sh
chmod u+x get_helm.sh
./get_helm.sh

kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-role --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

helm init --service-account tiller --upgrade 
helm install stable/nginx-ingress --name my-nginx --set rbac.create=true
