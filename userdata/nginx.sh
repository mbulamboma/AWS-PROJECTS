#!/bin/bash
sudo yum update -y

# installing git
sudo yum install -y git


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
rm -rf /home/ec2-user/fuel-consumption-back-end/
git clone https://oauth2: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@github.com/Fuel-Consumption-plateform/fuel-consumption-back-end.git

# move to the downloaded folder
cd /home/ec2-user/fuel-consumption-back-end/
pm2 stop all
pm2 delete all
npm install --force
pm2 start "npm run start:prod"  --name "backend" 



# installing nginx and load balance on port 4000
sudo yum install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo yum install -y jq

sudo cat >  /home/ec2-user/load-balancer.conf << EOF
upstream backend {
    server 127.0.0.1:3000;
    server 127.0.0.1:3001;
    server 127.0.0.1:3002;  
}

server {
    listen 4000;
    server_name _;
    location / {
        proxy_pass http://backend;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

sudo mv /home/ec2-user/load-balancer.conf /etc/nginx/conf.d/load-balancer.conf
sudo systemctl restart nginx
