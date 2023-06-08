sudo amazon-linux-extras list | grep nginx
sudo amazon-linux-extras enable nginx1
sudo yum clean metadata
sudo yum -y install nginx
nginx -v



sudo cat >  /home/ec2-user/mongodb-nginx.conf << EOF
upstream backend {
    server 127.0.0.1:27017; 
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