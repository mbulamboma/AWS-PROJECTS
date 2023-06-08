sudo runuser -l  ec2-user -c  'cd /home/ec2-user/fuel-consumption-back-end/ && git pull'
sudo runuser -l  ec2-user -c  'cd /home/ec2-user/fuel-consumption-back-end/ && npm install' 
sudo runuser -l  ec2-user -c  'cd /home/ec2-user/fuel-consumption-back-end/ && pm2 start "npm run start:dev"  --name "backend"'
