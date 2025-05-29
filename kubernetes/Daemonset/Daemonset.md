# Daemonset 

A DaemonSet ensures that a copy of a Pod runs on all (or some) Nodes in your cluster.

# Use cases:

Running a log collector (e.g., Fluentd)

Monitoring agent (e.g., Prometheus Node Exporter)

Security agents

# A DaemonSet is a type of controller that ensures that all (or some) nodes in a cluster run a copy of a specific pod. It is often used 

for system-level tasks that should be run on every node, such as log collection, monitoring, or other types of

background tasks

 # When you create a DaemonSet, Kubernetes automatically creates a pod on each node that matches the specified label selector. 

# If a new node is added to the cluster, Kubernetes automatically creates a new pod on that node as well

 By using labels and node selectors, you can specify which nodes in the Kubernetes cluster should run a 
 
particular DaemonSet. This allows you to restrict the execution of the DaemonSet to specific nodes

# Apply Yaml file

kubectl apply -f nginx-daemonset.yaml

# Check DaemonSet Status

kubectl get daemonset

kubectl get daemonset

NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE

nginx-daemonset   1         1         1       1            1           <none>          89s

# See the Pods Running on Nodes

kubectl get pods -o wide

# View logs

kubectl logs nginx-daemonset-x7p92

# Delete the DaemonSet

kubectl delete daemonset nginx-daemonset

# Output:

daemonset.apps "nginx-daemonset" deleted


# Confirm Deletion

kubectl get daemonset

# Check Pods

kubectl get pods -o wide | grep nginx

#  Delete using YAML file

kubectl delete -f nginx-daemonset.yaml




