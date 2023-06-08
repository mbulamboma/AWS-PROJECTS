#!/bin/bash
sudo yum update -y

# installing git
sudo yum install -y git

cd /home/ec2-user/ 

# install node js
sudo runuser -l  ec2-user -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash'
sudo runuser -l  ec2-user -c '. /home/ec2-user/.nvm/nvm.sh'
sudo runuser -l  ec2-user -c  'nvm install 16'
node -e "console.log('Running Node.js ' + process.version)"

# install pm2
sudo runuser -l  ec2-user -c 'npm install -g pm2'


# deploying code
cd /home/ec2-user/ 
rm -rf /home/ec2-user/KumbaBackend/
sudo runuser -l  ec2-user -c 'git clone https://oauth2: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@github.com/KumbaDevTeam/KumbaBackend.git'

# move to the downloaded folder

sudo runuser -l  ec2-user -c  'sudo chown ec2-user:ec2-user -R /home/ec2-user/KumbaBackend'
sudo runuser -l  ec2-user -c  'cd /home/ec2-user/KumbaBackend/ && npm install --force'
sudo runuser -l  ec2-user -c  'pm2 stop all'
sudo runuser -l  ec2-user -c  'pm2 delete all' 
sudo runuser -l  ec2-user -c  'cd /home/ec2-user/KumbaBackend/ && pm2 start "npm run start:dev"  --name "backend"'
