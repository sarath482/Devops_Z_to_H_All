# Endpoint :

Endpoints are automatically created and managed by Kubernetes when you create a Service, and they are updated 
dynamically as Pods are added or removed from the Service.

It lists the actual IP addresses (and ports) of the Pods that the Service routes traffic to.

# When is it used (Real-Time )

When using a ClusterIP, NodePort, or LoadBalancer service:

Kubernetes automatically creates an Endpoints object.

It keeps track of Pod IPs that match the selector in your Service.

# Example Yaml:

apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: my-app
  ports:
    - port: 80
      targetPort: 8080

# The corresponding Endpoints object will list the Pods with app=my-app and port 8080.

When a client sends a request via the Service, kube-proxy or CNI will forward the request to one of the IPs in the Endpoints object (i.e., to a running Pod).

For DNS resolution:

When you curl my-service, DNS resolves it using Endpoints.

# Real-World Example:

Suppose you have a frontend app that calls a backend API:

Backend Pods are deployed with labels app=backend.

A Kubernetes Service named backend-service is created to expose backend Pods.

When frontend calls http://backend-service, Kubernetes routes traffic using the Endpoints object, which has the IPs of the backend Pods.

# How to View Endpoints?

kubectl get endpoints

kubectl get endpoints

NAME         ENDPOINTS           AGE

kubernetes   192.168.65.4:6443   188d

kubectl get endpoints -n my-namespace

kubectl describe endpoints my-service

# Service → Endpoints → Pods


# DNS

 If a Pod located in the "default" namespace needs to communicate with a service named "nginx-service" residing 

in the "dev" namespace, it can do so by using the URL "http://nginx-service.dev.svc.cluster.local".

The default DNS provider in Kubernetes is CoreDNS, which runs as pods/containers inside the cluster. 

CoreDNS retrieves pod/service information from the Kubernetes API to update its DNS records

# Notice:

Kubernetes does not automatically create DNS records for Pod names directly. This is because Pod IPs keep

changing whenever Pods are recreated or  rescheduled.Instead, stable DNS records are maintained at the Service level

in Kubernetes. Services have unchanging virtual IPs that act as stable endpoints.

# Pod dns policy 

Pod's DNS settings can be configured based on the dnsPolicy field in a Pod specification. This dnsPolicy field

accepts three possible values:

# ClusterFirst: 

Any DNS query that does not match the configured search domains for the Pod are 

forwarded to the upstream nameserver. This is the default policy if dnsPolicy is not specified.

# None: 

Allows a Pod to ignore DNS settings from the Kubernetes environment. All DNS settings

are supposed to be provided using the dnsConfig field in the Pod Spec.

# Default: 

Use the DNS settings of the node that the Pod is running on. This means it will use the 

same DNS as the node that the Pod runs on.

