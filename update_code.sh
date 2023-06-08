#!/bin/bash

# Change to the project directory
cd /home/ec2-user/fuel-consumption-back-end/

# Pull latest changes from the git repository
git pull

# stop all running process
docker stop $(docker ps -q)

# Remove the existing Docker image with the name "backend-app"
docker rmi -f backend-app || true

# Build a new Docker image with the name "backend-app"
docker build -t backend-app .

# launch the server
docker run -p 80:3000 backend-app 