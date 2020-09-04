


clear
echo -e "\033[36m"
echo -e "██╗   ██╗███████╗██╗  ██╗ █████╗ ███╗   ██╗"
echo -e "██║   ██║██╔════╝██║ ██╔╝██╔══██╗████╗  ██║"
echo -e "██║   ██║█████╗  █████╔╝ ███████║██╔██╗ ██║"
echo -e "██║   ██║██╔══╝  ██╔═██╗ ██╔══██║██║╚██╗██║"
echo -e "╚██████╔╝██║     ██║  ██╗██║  ██║██║ ╚████║"
echo -e " ╚═════╝ ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝"
echo -e "\033[35m"
echo "-----LEMP INSTALLATION SCRIPT-----"
echo "-----UBUNTU20.04--PHP7.4--MYSQl8.0----"
echo -e "\033[0m"
echo "Installation initializing..."

sleep 5
apt purge apache2
apt update && apt full-upgrade -y

apt install nginx -y

apt install mysql-server -y

printf "CREATE DATABASE wordpress CHARACTER SET UTF8 COLLATE utf8_bin;\nCREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'Password1';\nGRANT ALL PRIVILEGES ON * . * TO 'wordpressuser'@'localhost';\nFLUSH PRIVILEGES;\nexit\n" | mysql

apt install php php-cli php-fpm php-json php-pdo php-mysql php-zip php-gd  php-mbstring php-curl php-xml php-pear php-bcmath -y
sleep 1
cd  /var/www/html

mkdir -p ufkan.com

cd /tmp

wget https://wordpress.org/latest.tar.gz

tar xf latest.tar.gz

mv /tmp/wordpress/* /var/www/html/ufkan.com/


chown -R www-data: /var/www/html/ufkan.com

cd /etc/nginx/sites-available

touch ufkan.com

echo "server {
  listen 80;
  listen [::]:80;
  server_name www.ufkan.com ufkan.com;
  root /var/www/html/ufkan.com/;
  index index.php index.html index.htm index.nginx-debian.html;

  location / {
    try_files \$uri \$uri/ /index.php;
  }

  error_page 404 /404.html;
  error_page 500 502 503 504 /50x.html;

  location = /50x.html {
    root /usr/share/nginx/html;
  }

  location ~ \.php$ {
    fastcgi_pass unix:/run/php/php7.4-fpm.sock;
    fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    include fastcgi_params;
    include snippets/fastcgi-php.conf;
  }

  #enable gzip compression
  gzip on;
  gzip_vary on;
  gzip_min_length 1000;
  gzip_comp_level 5;
  gzip_types application/json text/css application/x-javascript application/javascript image/svg+xml;
  gzip_proxied any;

  # A long browser cache lifetime can speed up repeat visits to your page
  location ~* \.(jpg|jpeg|gif|png|webp|svg|woff|woff2|ttf|css|js|ico|xml)$ {
       access_log        off;
       log_not_found     off;
       expires           360d;
  }

  # disable access to hidden files
  location ~ /\.ht {
      access_log off;
      log_not_found off;
      deny all;
  }

location = /wp-config-sample.php {
 log_not_found off;
 access_log off;
 return 404;
 break;
}
location = /wp-config.php {
 log_not_found off;
 access_log off;
 return 404;
 break;
}
location = /htaccess.txt {
 log_not_found off;
 access_log off;
 return 404;
 break;
}
location = /LEGGIMI.txt {
 log_not_found off;
 access_log off;
 return 404;
 break;
}
location = /license.txt {
 log_not_found off;
 access_log off;
 return 404;
 break;
}
location = /licenza.html {
 log_not_found off;
 access_log off;
 return 404;
 break;
}
location = /readme.html {
 log_not_found off;
 access_log off;
 return 404;
 break;
}





}
" >> ufkan.com


ln -s /etc/nginx/sites-available/ufkan.com /etc/nginx/sites-enabled/
sleep 1

nginx -t

systemctl restart nginx

echo -e "\033[36m"
echo "-----Installation Done-----"
echo "-----Dont forget to add the IP and URL to your host-----"
echo "-----Open your browser and type ufkan.com-----"











