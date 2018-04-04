sleep 30

n98-magerun.phar local-config:generate -q localhost root "" magento files admin;
n98-magerun.phar db:create ;
n98-magerun.phar db:import magento_sample_data_for_1.9.2.4.sql ;
url=http://127.0.0.1/
n98-magerun.phar config:set "web/secure/base_url" $url ;
n98-magerun.phar config:set "web/unsecure/base_url" $url ;
n98-magerun.phar admin:user:create $ADMIN_USER $ADMIN_EMAIL $ADMIN_PASSWORD $ADMIN_FIRSTNAME $ADMIN_FIRSTNAME ;
n98-magerun.phar customer:create $ADMIN_EMAIL $ADMIN_PASSWORD $ADMIN_FIRSTNAME $ADMIN_FIRSTNAME -q ;
n98-magerun.phar admin:notifications ;
n98-magerun.phar design:demo-notice --off --global -q ;
n98-magerun.phar config:set web/seo/use_rewrites 0 ;
n98-magerun.phar cache:disable ;nr;nc ;
chmod -R 755 /var/www/html
chmod -R o+w media var ;
chmod o+w app/etc ;
find . -type d -exec chmod 775 '{}' ;
find . -type f -exec chmod 644 '{}' ;
chmod -Rv 777 app/etc var/ media/ ;

rm -f /etc/supervisor/conf.d/supervisord-zmagento.conf