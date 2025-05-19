# MINIKUBE AND DOCKER INSTALLATION ON AMAZONLINUX 
# Update the packages and package caches in instance.

yum update -y

# Install the latest Docker Engine packages.
 yum install docker-y

# Start the Docker service.

 systemctl start docker

 systemctl enable docker

# Install Conntrack and Minikube

 yum install conntrack -y

 curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Start your MINIKUBE

minikube start --force --driver=docker

minikube version

# Start your MINIKUBE

 /usr/local/bin/minikube start --force --driver=docker

# Reliable Official Maven

wget https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz

# Extract 

tar -xvzf apache-maven-3.6.3-bin.tar.gz



# Git 

sudo yum install git  -y

# Java

sudo  yum install java -y

# Install kubectl 
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.20.4/2021-04-12/bin/linux/amd64/kubectl

# Make it executable:

chmod +x ./kubectl

# Create a bin directory if it doesn’t exist
mkdir -p $HOME/bin

# Move the binary to your bin directory
cp ./kubectl $HOME/bin/kubectl

# Update your PATH
export PATH=$HOME/bin:$PATH

# Persist PATH in your shell config
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Check kubectl version

kubectl version --short --client

git clone https://github.com/praveen1994dec/kubernetes_java_deployment.git

Build images and push this images in github.

Then run kubernetes commands

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
Pod ⟶ Volume               mount Inside the Pod YAML under volumeMounts[].name and volumes[].name










