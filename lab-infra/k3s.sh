#!/bin/bash

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode 644" sh -s -

# wait until ready
while true;
do
    if [ "$(kubectl get nodes server -o=jsonpath='{.status.conditions[3].status}')" == "True" ]; then
      break;
    fi
    sleep 5;
done

# Based on https://github.com/k3s-io/k3s/issues/1160#issuecomment-1133559423
# remove k3s default ingress controller
kubectl -n kube-system delete helmchart traefik traefik-crd
sudo touch /var/lib/rancher/k3s/server/manifests/traefik.yaml.skip
sudo systemctl restart k3s

echo "Done"