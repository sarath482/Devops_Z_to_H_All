# How scheduling works ?

When a Pod is created , it is not assigned to any specific Node initially. instead, the Pod is marked as "unscheduled" 

and is added to a scheduling queue. The scheduler continuously

watches this queue and selects an appropriate Node for each unscheduled Pod.The scheduler uses a set of rules to 

determine which nodes are eligible for scheduling. 

# Scheduling Rules and different ways :

1. Resource requirements:

2.  Node capacity: 

3.  Taints and tolerations:

4.  Node selectors:

5. Affinity/anti-Affinity:

# 1. Resource requirements: 

The scheduler looks at the CPU and memory requirements  specified in the pod's configuration and ensures that the

selected node has enough available resources to run the pod

# 2.  Node capacity: 

The scheduler considers the capacity of each node in the cluster, including the amount of available CPU, memory, and 

storage, and selects a node  that has sufficient capacity to meet the pod's requirements

# 3.  Taints and tolerations:

Nodes in a Kubernetes cluster can be tainted to indicate that they have specific  restrictions on the pods that can be 

scheduled on them. Pods can specify tolerations for these taints, which allow them to be scheduled on the tainted nodes.

# 4. Node selectors:

Users can also specify node selectors, which are labels that are applied to nodes in the cluster. The scheduler can 

use these selectors to filter out nodes that don't match the pod's requirements.

# 5 . Affinity/anti-Affinity:

Kubernetes allows users to specify affinity and anti-affinity rules that control which nodes pods can be scheduled on. 

For example, a pod may be required to run on a node that has a specific label, or it may be prohibited from running on 

a node that already has a pod with a certain label.

# Taint the Node:

kubectl taint nodes docker-desktop dedicated=backend:NoSchedule

# Pod YAML WITH Toleration (Will Run on Tainted Node)

# backend-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: backend-pod
spec:
  tolerations:
  - key: "dedicated"
    operator: "Equal"
    value: "backend"
    effect: "NoSchedule"
  containers:
  - name: backend-container
    image: nginx

# Apply this Pod

kubectl apply -f backend-pod.yaml

# Pod YAML WITHOUT Toleration (Will Not Run on Tainted Node):

# frontend-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: frontend-pod
spec:
  containers:
  - name: frontend-container
    image: nginx

# kubectl apply -f frontend-pod.yaml

# View Node and Taint

kubectl describe node docker-desktop

o/p: Taints: dedicated=backend:NoSchedule

# Remove the Taint (if needed):

kubectl taint nodes docker-desktop dedicated=backend:NoSchedule-

# TYPES

Type	                            Purpose

Node Affinity	Schedule Pods on specific nodes based on node labels.

Pod Affinity	Schedule Pods with other Pods (on same node).

Pod Anti-Affinity	Schedule Pods away from other Pods (on different nodes).

# Node Affinity – Example

Run pods only on nodes labeled zone=us-west-1.

apiVersion: v1
kind: Pod
metadata:
  name: node-affinity-pod
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: zone
            operator: In
            values:
            - us-west-1
  containers:
  - name: nginx
    image: nginx


# Apply label to node:

kubectl label nodes node-affinity-pod zone=us-west-1

#   Pod Affinity – Example

Schedule Pods on the same node as others with label app=frontend

apiVersion: v1
kind: Pod
metadata:
  name: pod-affinity-pod
spec:
  affinity:
    podAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchLabels:
            app: frontend
        topologyKey: "kubernetes.io/hostname"
  containers:
  - name: nginx
    image: nginx


# Pod Anti-Affinity – Example

Ensure pods do not run on the same node as others labeled app=frontend.

apiVersion: v1
kind: Pod
metadata:
  name: pod-anti-affinity-pod
spec:
  affinity:
    podAntiAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchLabels:
            app: frontend
        topologyKey: "kubernetes.io/hostname"
  containers:
  - name: nginx
    image: nginx

kubectl taint nodes docker-desktop key=value:NoSchedule-


 kubectl get deployments


kubectl delete deployment pod-with-affinity

kubectl delete deployment pod-with-anti-affinity

kubectl delete deployment pod-with-toleration

kubectl describe node docker-desktop | grep Taint

kubectl taint nodes docker-desktop --all

# Explanation Table

Feature	           Think of it as...	            Purpose	                                    Example Use Case

Taint	            "VIP table sign"	       Block regular pods from node	Reserve GPU node only for AI workloads

Toleration	        "VIP pass"	Let some pods  bypass taints	            AI pod has toleration for GPU node

Affinity	        "Friends sit together"	   Co-locate related pods	    Microservices that talk a lot

Anti-Affinity	    "Competitors separate"	   Spread pods across nodes	    High availability of replicas








