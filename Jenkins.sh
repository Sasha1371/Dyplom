#!/bin/bash

# Add user to Docker group (if script #3 is desired)
read -p "Add user to Docker group? (y/N): " add_to_docker
if [[ "$add_to_docker" =~ ^[Yy]$ ]]; then
  read -p "Enter username: " username
  sudo usermod -aG docker "$username"
  sudo service docker restart
fi

# Pull Jenkins Docker image
echo "Pulling Jenkins Docker image..."
sudo docker pull jenkins/jenkins

# Remove existing Jenkins container if it exists
if sudo docker ps -a --format '{{.Names}}' | grep -Eq "^jenkins\$"; then
  echo "Removing existing Jenkins container..."
  sudo docker rm -f jenkins
fi

# Run Jenkins Docker container on port 8080
echo "Running Jenkins Docker container..."
sudo docker run -d \
  --name jenkins \
  --privileged \
  -p 8080:8080 \
  -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts

# Display initial Jenkins password
echo "Waiting for Jenkins to initialize..."
sleep 30
echo "Initial Jenkins admin password:"
sudo docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

# Generate SSH key inside Jenkins Docker container
echo "Generating SSH key inside Jenkins Docker container..."

# Create .ssh directory in Jenkins home if it doesn't exist
sudo docker exec jenkins bash -c 'mkdir -p /var/jenkins_home/.ssh/'

# Generate SSH key pair
sudo docker exec -u jenkins jenkins ssh-keygen -t ed25519 -f /var/jenkins_home/.ssh/id_ed25519 -C "sashadrozdov@icloud.com" -q -N ""

# Display Jenkins generated SSH public key
echo "Jenkins SSH public key:"
sudo docker exec jenkins cat /var/jenkins_home/.ssh/id_ed25519.pub

# Display Jenkins generated SSH private key (for demonstration purposes, it's not recommended to display private keys)
echo "Jenkins SSH private key (**WARNING: Do not share this**):"
sudo docker exec jenkins cat /var/jenkins_home/.ssh/id_ed25519

# Add GitHub to known hosts for the Jenkins container
echo "Adding GitHub to known hosts for Jenkins container..."
sudo docker exec jenkins bash -c 'ssh-keyscan -t ed25519 github.com >> /var/jenkins_home/.ssh/known_hosts'

# Verifying known hosts
echo "Verifying known hosts:"
sudo docker exec jenkins cat /var/jenkins_home/.ssh/known_hosts
