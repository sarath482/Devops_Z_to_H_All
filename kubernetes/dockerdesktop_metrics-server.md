#  Install metrics-server in DockerDesktop

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Issue : 

kubectl top nodes

Error from server (ServiceUnavailable): the server is currently unable to handle the request (get nodes.metrics.k8s.io)

# Solution :

# If using Docker Desktop, you might also need to patch the deployment to allow insecure TLS (common in local setups) run below command.

kubectl patch deployment metrics-server -n kube-system \
  --type='json' \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'


# Then restart the metrics server:

kubectl rollout restart deployment metrics-server -n kube-system


kubectl top nodes

NAME             CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%

docker-desktop   440m         5%     2249Mi          60%

kubectl top pods

kubectl top pods

NAME                     CPU(cores)   MEMORY(bytes)

replicaset-nginx-vk4vd   0m           1Mi

# CPU

CPU(cores): 440m

This means the node is using 440 millicores of CPU.

1000m = 1 core, so:

440m = 0.44 CPU cores

# Memory

MEMORY(bytes): 2249Mi

Memory usage is 2249 MiB.

1 MiB = 1024 * 1024 bytes

2249 MiB ≈ 2.2 GiB of RAM used

#  Resource quotas examples

kubectl apply -f resource-quota.yaml
 
resourcequota/saas-team-quota created
