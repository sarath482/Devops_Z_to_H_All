#  Resource quotas apply commands

kubectl apply -f resource-quota.yaml
 
resourcequota/saas-team-quota created

# Verify ResourceQuota Applied

kubectl get resourcequota -n dev

NAME              AGE     REQUEST                                                                                                                                                                                                                                            LIMIT
saas-team-quota   6m15s   configmaps: 1/5, count/deployments.apps: 1/4, persistentvolumeclaims: 0/5, pods: 1/10, replicationcontrollers: 0/5, requests.cpu: 0/2, requests.memory: 0/2Gi, secrets: 0/5, services: 0/5, services.loadbalancers: 0/2, services.nodeports: 0/3   limits.cpu: 0/4, limits.memory: 0/4Gi


# For detailed info

kubectl describe resourcequota saas-team-quota -n dev

Name:                   saas-team-quota

Namespace:              dev
Resource                Used  Hard
--------                ----  ----
configmaps              1     5
count/deployments.apps  1     4
limits.cpu              0     4
limits.memory           0     4Gi
persistentvolumeclaims  0     5
pods                    1     10
replicationcontrollers  0     5
requests.cpu            0     2
requests.memory         0     2Gi
secrets                 0     5
services                0     5
services.loadbalancers  0     2
services.nodeports      0     3


# particular namespace how to describe pods info.

# Separate resource and name

kubectl describe pod/nginx-7855fc665-h88px -n dev

# Resource/name shorthand

kubectl describe pod/nginx-7855fc665-h88px -n dev

# Scale the ReplicaSet directly

kubectl scale rs replicaset-nginx --replicas=5

# Verify:

kubectl get pods -l app=nginx

#  Observe the Quota Error

kubectl run extra-pod --image=nginx -n dev

# output:

Error from server (Forbidden): pods "extra-pod" is forbidden: failed quota: saas-team-quota: must specify limits.cpu for: extra-pod; limits.memory for: extra-pod; requests.cpu for: extra-pod; requests.memory for: extra-pod

# kubectl get events -n dev | grep -i quota

74s         Warning   FailedCreate        replicaset/nginx-7855fc665   Error creating: pods "nginx-7855fc665-fm5k9" is forbidden: failed quota: saas-team-quota: must specify limits.cpu for: nginx; limits.memory for: nginx; requests.cpu for: nginx; requests.memory for: nginx

# get events/logs particular namespace

kubectl -n dev get events

# kubectl describe ns dev


Name:         dev

Labels:       kubernetes.io/metadata.name=dev
Annotations:  <none>
Status:       Active

Resource Quotas
  Name:                   saas-team-quota
  Resource                Used  Hard
  --------                ---   ---
  configmaps              1     5
  count/deployments.apps  1     4
  limits.cpu              0     4
  limits.memory           0     4Gi
  persistentvolumeclaims  0     5
  pods                    1     10
  replicationcontrollers  0     5
  requests.cpu            0     2
  requests.memory         0     2Gi
  secrets                 0     5
  services                0     5
  services.loadbalancers  0     2
  services.nodeports      0     3


# limitrange

kubectl apply -f limitrange.yaml 

limitrange/dev-resource-limits created


kubectl describe limitrange dev-resource-limits -n dev

Name:       dev-resource-limits
Namespace:  dev
Type        Resource  Min   Max    Default Request  Default Limit  Max Limit/Request Ratio
----        --------  ---   ---    ---------------  -------------  -----------------------
Container   cpu       50m   500m   50m              100m           -
Container   memory    32Mi  512Mi  64Mi             128Mi 

# List existing LimitRanges 

kubectl get limitrange -n dev

NAME                  CREATED AT
dev-resource-limits   2025-05-21T14:06:22Z

# Delete the LimitRange


kubectl delete limitrange dev-resource-limits -n dev

limitrange "dev-resource-limits" deleted

# Verify it’s gone:

kubectl get limitrange -n dev

No resources found in dev namespace

# Resource Requirements &  Limits with container

# To Apply This Deployment

kubectl apply -f nginx-deployment.yaml

kubectl get deployments -n dev

NAME    READY   UP-TO-DATE   AVAILABLE   AGE

nginx   3/3     3            3           8h

# pod info/logs

kubectl describe pod nginx-6bfbbcf846-wqvf6 -n dev

# To Delete the Deployment:

kubectl delete -f nginx-deployment.yaml

# or


kubectl delete deployment nginx -n dev

deployment.apps "nginx" deleted