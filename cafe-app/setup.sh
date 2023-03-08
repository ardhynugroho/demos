#!/bin/bash
set -x

docker pull nginxdemos/nginx-hello:plain-text
docker tag nginxdemos/nginx-hello:plain-text local-registry:5000/nginx-hello:plain-text
docker push local-registry:5000/nginx-hello:plain-text
# generate ssl certificate for cafe.example.com
openssl req -x509 -newkey rsa:4096 -days 365 -nodes -sha256 -keyout cafe.key -out cafe.crt -subj "/CN=cafe.example.com"
kubectl create secret tls cafe-secret --cert=cafe.crt --key=cafe.key
kubectl apply -f cafe.yaml