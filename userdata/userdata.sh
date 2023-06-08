
#!/bin/bash 
cd ~

sudo yum update -y

# installing git
sudo yum install -y git



# download code
cd /home/ec2-user/ 
sudo rm -rf /home/ec2-user/fuel-consumption-back-end/
git clone https://oauth2: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@github.com/Fuel-Consumption-plateform/fuel-consumption-back-end.git


# install node js
sudo touch ~/.bashrc
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
sudo source ~/.bashrc
export NVM_DIR="$HOME/.nvm" 
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
nvm install 16
node -e "console.log('Running Node.js ' + process.version)"


# install pm2
npm install -g pm2


# deploying code
cd /home/ec2-user/ 
sudo rm -rf /home/ec2-user/fuel-consumption-back-end/
git clone https://oauth2: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@github.com/Fuel-Consumption-plateform/fuel-consumption-back-end.git

# move to the downloaded folder
cd /home/ec2-user/fuel-consumption-back-end/
pm2 stop all
pm2 delete all
npm install --force
pm2 start "npm run start:prod"  --name "backend" 
