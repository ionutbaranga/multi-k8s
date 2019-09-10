#!/usr/bin/env bash

# create a secret PGPASSWORD
#kubectl create secret generic pgpassword --from-literal PGPASSWORD=changeit

# Ingress mandatory config
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml

# Ingress & Docker for Mac specific config
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/cloud-generic.yaml