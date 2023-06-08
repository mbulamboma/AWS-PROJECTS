#!/bin/bash

# move to the directory
cd /home/ec2-user/fuel-consumption-back-end/
npm install
git pull && pm2 restart backend-app

cd /home/ec2-user/FuelConsumptionFT/
npm install
git pull && pm2 restart frontend
