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






