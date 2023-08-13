sudo rm -rf /var/www/*
cd /var/www
git clone https://oauth2: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@github.com/dnsanumeric/eticket.git
sudo mv /var/www/eticket/* /var/www/
sudo rm -rf /var/www/eticket
sudo rm -rf composer.lock
sudo rm -rf vendor/
composer install
php artisan key:generate
php artisan migrate
sudo chown www-data:www-data -R /var/www/
sudo chmod 777 -R /var/www/storage/logs/