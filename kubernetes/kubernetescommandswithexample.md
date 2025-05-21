# Build images and push this images in dockerhub.Then run kubernetes commands

docker build -t sarathdevops/stockmanager:latest .

docker push sarathdevops/stockmanager:latest

# Kubernetes 

kubectl apply-f shopfront-service.yaml
kubectl apply-f productcatalogue-service.yaml
kubectl apply-f stockmanager-service.yaml

# Issue
stockmanager-69fb476557-vlsx8       0/1     CrashLoopBackOff   9 (4m42s ago)   23m

Solution:

 spec:
      containers:
      - name: productcatalogue
        image: praveensingam1994/stockmanager:latest

Updated:

 spec:
      containers:
      - name: productcatalogue
        image: sarathdevops/stockmanager:latest
# Issue 
php-apache-6487c65df8-5p7pp         0/1     ImagePullBackOff   0          115s

Events:
  Type     Reason     Age                 From               Message
  ----     ------     ----                ----               -------
  Normal   Scheduled  106s                default-scheduler  Successfully assigned default/php-apache-6487c65df8-5p7pp to minikube
  Normal   Pulling    45s (x3 over 105s)  kubelet            Pulling image "registry.k8s.io/hpa-example"
  Warning  Failed     36s (x3 over 96s)   kubelet            Failed to pull image "registry.k8s.io/hpa-example": failed to register layer: write /usr/lib/x86_64-linux-gnu/libpthread.a: no space left on device
  Warning  Failed     36s (x3 over 96s)   kubelet            Error: ErrImagePull
  Normal   BackOff    0s (x5 over 95s)    kubelet            Back-off pulling image "registry.k8s.io/hpa-example"
  Warning  Failed     0s (x5 over 95s)    kubelet            Error: ImagePullBackOff

# Solution
# lscase1 : Clean up space

docker system prune -a -f

# PV and PVC And Pod

Pod --> volumeMount (name=my-storage)
      --> volume (name=my-storage, pvc=my-pvc)
               --> PersistentVolumeClaim (my-pvc)
                     --> Bound to PersistentVolume (my-pv)

# Relationship          	Location in YAML

PVC ⟶ PV	               Kubernetes automatically matches them based on size and access mode.
Pod ⟶ PVC	               Inside the Pod YAML under volumes[].persistentVolumeClaim.claimName
Pod ⟶ Volume               mount git Inside the Pod YAML under volumeMounts[].name and volumes[].name

# Delete Deployments
These will automatically delete associated ReplicaSets and Pods.

kubectl delete deployment flask-demo

# Delete Services
Remove the exposed services:

kubectl delete service flask-service


# Replicaset Example

kubectl apply -f replicaset-nginx.yaml

kubectl describe replicaset replicaset-nginx

#  scale the number of replicas of a ReplicaSet using the kubectl scale command

# Scale up

kubectl scale replicaset replicaset-nginx --replicas=6
replicaset.apps/replicaset-nginx scaled

# Scale down 
kubectl scale replicaset replicaset-nginx --replicas=1
replicaset.apps/replicaset-nginx scaled

# Create namespace if not already created
kubectl create namespace dev
namespace/dev created

# Deployment with examples
kubectl apply -f deployment.yaml --namespace=dev
deployment.apps/nginx created

# How to verify pods in a particular namespace


kubectl get pods --namespace=dev
NAME                    READY   STATUS    RESTARTS   AGE
nginx-7855fc665-757tf   1/1     Running   0          25s

kubectl get pods -n dev
NAME                    READY   STATUS    RESTARTS   AGE
nginx-7855fc665-757tf   1/1     Running   0          3m10s
nginx-7855fc665-f7xqc   1/1     Running   0          3m10s
nginx-7855fc665-jq4mj   1/1     Running   0          3m10s

# To view all Pods, Services, and other resources across all namespaces in a single command
kubectl get all --all-namespaces

NAMESPACE     NAME                                         READY   STATUS    RESTARTS         AGE
default       pod/replicaset-nginx-vk4vd                   1/1     Running   0                61m
dev           pod/nginx-7855fc665-757tf                    1/1     Running   0                13m
NAMESPACE     NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
default       service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP                  181d
kube-system   service/kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   181d

NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system   daemonset.apps/kube-proxy   1         1         1       1            1           kubernetes.io/os=linux   181d

NAMESPACE     NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
dev           deployment.apps/nginx     3/3     3            3           13m
kube-system   deployment.apps/coredns   2/2     2            2           181d

NAMESPACE     NAME                                DESIRED   CURRENT   READY   AGE
default       replicaset.apps/replicaset-nginx    1         1         1       61m
dev           replicaset.apps/nginx-7855fc665     3         3         3       13m
kube-system   replicaset.apps/coredns-95db45d46   2         2         2       181d

# -o wide for more info This adds details like node name, pod IP, and container image
kubectl get all --all-namespaces -o wide

NAMESPACE     NAME                                         READY   STATUS    RESTARTS         AGE    IP             NODE             NOMINATED NODE   READINESS GATES
default       pod/replicaset-nginx-vk4vd                   1/1     Running   0                64m    10.1.0.88      docker-desktop   <none>           <none>

NAMESPACE     NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE    SELECTOR
default       service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP                  181d   <none>
kube-system   service/kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   181d   k8s-app=kube-dns

NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE    CONTAINERS   IMAGES                          SELECTOR
kube-system   daemonset.apps/kube-proxy   1         1         1       1            1           kubernetes.io/os=linux   181d   kube-proxy   k8s.gcr.io/kube-proxy:v1.25.2   k8s-app=kube-proxy

NAMESPACE     NAME                      READY   UP-TO-DATE   AVAILABLE   AGE    CONTAINERS   IMAGES                      SELECTOR
dev           deployment.apps/nginx     3/3     3            3           16m    nginx        nginx:1.17                  app=nginx
kube-system   deployment.apps/coredns   2/2     2            2           181d   coredns      k8s.gcr.io/coredns:v1.9.3   k8s-app=kube-dns

NAMESPACE     NAME                                DESIRED   CURRENT   READY   AGE    CONTAINERS   IMAGES                      SELECTOR
default       replicaset.apps/replicaset-nginx    1         1         1       64m    nginx        nginx:1.17                  app=nginx
dev           replicaset.apps/nginx-7855fc665     3         3         3       16m    nginx        nginx:1.17                  app=nginx,pod-template-hash=7855fc665
kube-system   replicaset.apps/coredns-95db45d46   2         2         2       181d   coredns      k8s.gcr.io/coredns:v1.9.3   k8s-app=kube-dns,pod-template-hash=95db45d46

# kubectl get pods -o wide
NAME                     READY   STATUS    RESTARTS   AGE   IP          NODE             NOMINATED NODE   READINESS GATES
replicaset-nginx-vk4vd   1/1     Running   0          69m   10.1.0.88   docker-desktop   <none>           <none>

 # kubectl get deployment -n dev
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
nginx   3/3     3            3           25m

#  a deployment named nginx in the dev namespace, and you want to scale it to 5 replicas:

# Particular namespace Scale Up
kubectl scale deployment nginx --replicas=5 --namespace=dev
deployment.apps/nginx scaled

# Particular name space Scale Down
kubectl scale deployment nginx --replicas=1 --namespace=dev
deployment.apps/nginx scaled

# kubectl get pods -n dev
NAME                    READY   STATUS    RESTARTS   AGE
nginx-7855fc665-jq4mj   1/1     Running   0          29m

# 0 Scale
kubectl scale deployment nginx --replicas=0 --namespace=dev
deployment.apps/nginx scaled
# kubectl get pods -n dev
NAME                    READY   STATUS    RESTARTS   AGE
nginx-7855fc665-h88px   1/1     Running   0          3m46s

# To list all Pods across all namespaces using a single command,
kubectl get pods --all-namespaces
NAMESPACE     NAME                                     READY   STATUS    RESTARTS           AGE
default       replicaset-nginx-vk4vd                   1/1     Running   0                  83m
dev           nginx-7855fc665-h88px                    1/1     Running   0                  2m25s
kube-system   coredns-95db45d46-lx5tb                  1/1     Running   14 (5d14h ago)     181d
