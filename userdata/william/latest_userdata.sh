#!/bin/bash
# installing git
sudo yum install -y git 

# install node js
sudo runuser -l  ec2-user -c 'cd /home/ec2-user/ && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash'
sudo runuser -l  ec2-user -c '. /home/ec2-user/.nvm/nvm.sh'
sudo runuser -l  ec2-user -c  'cd /home/ec2-user/ && nvm install 16' 

# install pm2
sudo runuser -l  ec2-user -c 'npm install -g pm2'


# deploying code 
rm -rf /home/ec2-user/fuel-consumption-back-end/
sudo runuser -l  ec2-user -c 'cd /home/ec2-user/ && git clone https://oauth2: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@github.com/Fuel-Consumption-plateform/fuel-consumption-back-end.git'

# move to the downloaded folder

sudo runuser -l  ec2-user -c  'sudo chown ec2-user:ec2-user -R /home/ec2-user/fuel-consumption-back-end'
sudo runuser -l  ec2-user -c  'cd /home/ec2-user/fuel-consumption-back-end/ && npm install'
sudo runuser -l  ec2-user -c  'pm2 stop all'
sudo runuser -l  ec2-user -c  'pm2 delete all' 
sudo runuser -l  ec2-user -c  'cd /home/ec2-user/fuel-consumption-back-end/ && pm2 start "npm run start:dev"  --name "backend"'
