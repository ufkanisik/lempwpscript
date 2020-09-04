


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
mysql_secure_installation
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

#---------------------------------------------------------------------

cd /var/www/html/ufkan.com

rm -r wp-config-sample.php

cd /var/www/html/ufkan.com

touch wp-config.php

echo "<?php
/**
 * WordPress için taban ayar dosyası.
 *
 * Bu dosya şu ayarları içerir: MySQL ayarları, tablo öneki,
 * gizli anahtaralr ve ABSPATH. Daha fazla bilgi için
 * {@link https://codex.wordpress.org/Editing_wp-config.php wp-config.php düzenleme}
 * yardım sayfasına göz atabilirsiniz. MySQL ayarlarınızı servis sağlayıcınızdan edinebilirsiniz.
 *
 * Bu dosya kurulum sırasında wp-config.php dosyasının oluşturulabilmesi için
 * kullanılır. İsterseniz bu dosyayı kopyalayıp, ismini "wp-config.php" olarak değiştirip,
 * değerleri girerek de kullanabilirsiniz.
 *
 * @package WordPress
 */

// ** MySQL ayarları - Bu bilgileri sunucunuzdan alabilirsiniz ** //
/** WordPress için kullanılacak veritabanının adı */
define( 'DB_NAME', 'wordpress' );

/** MySQL veritabanı kullanıcısı */
define( 'DB_USER', 'wordpressuser' );

/** MySQL veritabanı parolası */
define( 'DB_PASSWORD', 'Password1' );

/** MySQL sunucusu */
define( 'DB_HOST', 'localhost' );

/** Yaratılacak tablolar için veritabanı karakter seti. */
define( 'DB_CHARSET', 'utf8mb4' );

/** Veritabanı karşılaştırma tipi. Herhangi bir şüpheniz varsa bu değeri değiştirmeyin. */
define('DB_COLLATE', '');

/**#@+
 * Eşsiz doğrulama anahtarları.
 *
 * Her anahtar farklı bir karakter kümesi olmalı!
 * {@link http://api.wordpress.org/secret-key/1.1/salt WordPress.org secret-key service} servisini kullanarak yaratabilirsiniz.
 * Çerezleri geçersiz kılmak için istediğiniz zaman bu değerleri değiştirebilirsiniz. Bu tüm kullanıcıların tekrar giriş yapmasını gerektirecektir.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '[Kj@#<;aV^lv0r4C4:h\$G}>L++&11mKY4-L>=tU\$yU]w(6!n2n}rzE-4vYaJ[^6V' );
define( 'SECURE_AUTH_KEY',  '}(W*N(>lMwIt}hVc_ix~sEx&|T DxH)tvT=./B }Eyr-kl\`*A]yu=cvyBfPcQ0o}' );
define( 'LOGGED_IN_KEY',    'jEPHjr;QAqJl33tc%cUEDzIu!OxC){Jfz[$mx5LfS.e>Wzksdru-?LN=Pq>rT(uN' );
define( 'NONCE_KEY',        '+.w9MSIyAru8K^1IgWmxpM]dHd+\`4*Q;[#[7&]Ig:dEz=.yPVvXBY;,$^cw1.33$' );
define( 'AUTH_SALT',        'ceb)e{(hLmEId; Mdp<I{*idPu2tbs\`MKpd{kvK>1qmiZrFJp^u~zZNt&{VTH>js' );
define( 'SECURE_AUTH_SALT', '>(Dx#,D}BF}#|puN]5-%/H%s[n]1hlfQ)?~bbIeF(u>-|v&;A* ]nu)#KPm[h@:V' );
define( 'LOGGED_IN_SALT',   'gn/abA:hPds5!hpMjT)mmlk6Y D/NoCfO.alA3lKo\$@:8Y1P Pa2R%\`NHxc-[ns@' );
define( 'NONCE_SALT',       '>HU_DV5gbZdH,Zys@5.V:S@?XNcWjsEiq(_uJbB,Gk<U{WZ\$\$49edj4^+!\$Y yn;' );
/**#@-*/

/**
 * WordPress veritabanı tablo ön eki.
 *
 * Tüm kurulumlara ayrı bir önek vererek bir veritabanına birden fazla kurulum yapabilirsiniz.
 * Sadece rakamlar, harfler ve alt çizgi lütfen.
 */
\$table_prefix = 'wp_';

/**
 * Geliştiriciler için: WordPress hata ayıklama modu.
 *
 * Bu değeri true yaparak geliştirme sırasında hataların ekrana basılmasını sağlayabilirsiniz.
 * Tema ve eklenti geliştiricilerinin geliştirme aşamasında WP_DEBUG
 * kullanmalarını önemle tavsiye ederiz.
 */
define('WP_DEBUG', false);

/* Hepsi bu kadar. Mutlu bloglamalar! */

/** WordPress dizini için mutlak yol. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** WordPress değişkenlerini ve yollarını kurar. */
require_once(ABSPATH . 'wp-settings.php');" >> wp-config.php

#--------------------------------------------------------------------

ln -s /etc/nginx/sites-available/ufkan.com /etc/nginx/sites-enabled/
sleep 1

nginx -t

systemctl restart nginx
rm -r /tmp/latest.tar.gz
apt purge apache2
echo -e "\033[36m"
echo "-----Installation Done-----"
echo "-----Dont forget to add the IP and URL to your host-----"
echo "-----Open your browser and type ufkan.com-----"
echo -e "\033[0m"










