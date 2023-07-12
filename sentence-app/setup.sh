#!/bin/bash
set -x
git clone https://github.com/f5devcentral/sentence-demo-app.git
cd sentence-demo-app/k8s-manifests

kubectl create ns api
kubectl create ns webapp-nginx
kubectl apply -f sentence-api-all.yaml -n api
kubectl apply -f sentence-nginx-webapp.yaml -n webapp-nginx

kubectl apply -f ingress-vs-master.yaml
kubectl apply -f ingress-vs-route-api.yaml -n api
kubectl apply -f ingress-vs-route-frontend.yaml -n webapp-nginx
