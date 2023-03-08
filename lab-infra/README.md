# Setup the infra

## IP addresses

### Management 10.1.1.0/24

- client 10.1.1.6
- bigip 10.1.1.4
- server 10.1.1.5

### client-side 10.1.10.0/24 

- client 10.1.10.10
- server 10.1.10.20
- bigip 10.1.10.5

### server-side 10.1.20.0/24

- bigip 10.1.20.5
- client 10.1.20.10
- server 10.1.20.20

### Enable interface ens6 for Ubuntu server & client

```
cp 99-ens6.yaml /etc/netplan/
```

Apply the config

```
sudo netplan apply
```

### Change the hostname

example: nodename = server
```
export nodename=server
sudo hostname $nodename
sudo sh -c "echo $nodename > /etc/hostname"
```

exit and re-login

## Execution steps

1. docker.sh
2. k3s.sh
3. local-registry.sh
4. nginx-ingress.sh

## Test local registry setup

Pull then push to local-registry

```
docker pull nginx
docker tag nginx:latest local-registry:5000/nginx:latest
docker push local-registry:5000/nginx:latest
```

Run a pod using image in the local-registry

```
    kubectl run nginx-pod --image=local-registry:5000/nginx --overrides='{ "apiVersion": "v1", "spec": { "imagePullSecrets": [{"name": "local-registry-cred"}] } }'
```