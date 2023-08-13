cd /home/ec2-user/ 
rm -rf /home/ec2-user/KumbaBackend/
sudo runuser -l  ec2-user -c 'git clone https://oauth2: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@github.com/KumbaDevTeam/KumbaBackend.git'

# move to the downloaded folder
sudo runuser -l  ec2-user -c  'sudo chown ec2-user:ec2-user -R /home/ec2-user/KumbaBackend' 
cd /home/ec2-user/KumbaBackend/
sudo runuser -l  ec2-user -c  'cd /home/ec2-user/KumbaBackend/ && rm -rf package-lock.json'
sudo runuser -l  ec2-user -c  'cd /home/ec2-user/KumbaBackend/ && yarn install'
sudo runuser -l  ec2-user -c  'pm2 stop all'
sudo runuser -l  ec2-user -c  'pm2 delete all' 
sudo runuser -l  ec2-user -c  'sudo ./killprocess.sh' 
sudo runuser -l  ec2-user -c  'cd /home/ec2-user/KumbaBackend/ && pm2 start "yarn run start:dev"  --name "backend"'