#!/bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 16
node -e "console.log('Running Node.js ' + process.version)"


sudo yum install -y git

cd /home/ec2-user/ 

rm -rf /home/ec2-user/FuelConsumptionFT/

FuelConsumptionFT
git clone https://oauth2:xxxxxx@github.com/Fuel-Consumption-plateform/FuelConsumptionFT.git || true

# Change to the project directory
cd /home/ec2-user/FuelConsumptionFT/


#install 
npm install --force  @angular/cli

#install all
npm install --force

npm install -g pm2

pm2 start  --name "FuelConsumptionFT" -- start npm run start

pm2 log FuelConsumptionFT --raw >> my-angular-app.log
