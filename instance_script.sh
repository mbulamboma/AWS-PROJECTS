sudo yum update

# ------- installing docker -------- #

sudo yum install -y docker ## install docker

# Add group membership for the default ec2-user 
# so you can run all docker commands without using the sudo command
sudo usermod -a -G docker ec2-user


# 1. Get pip3 
sudo yum install -y python3-pip
 
# 2. Then run any one of the following
sudo pip3 install -y docker-compose # with root access

# Enable docker 
sudo systemctl enable docker.service


#start docker
sudo systemctl start docker.service