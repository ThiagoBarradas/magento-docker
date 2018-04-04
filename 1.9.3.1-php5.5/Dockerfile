FROM thiagobarradas/lamp:php-5.5
MAINTAINER Thiago Barradas <th.barradas@gmail.com>

# VARIABLES
ENV MAGENTO_VERSION=1.9.3.1
ENV ADMIN_FIRSTNAME="Admin" 
ENV ADMIN_LASTNAME="Test" 
ENV ADMIN_EMAIL="admin-magento2@mailinator.com" 
ENV ADMIN_USER="admin" 
ENV ADMIN_PASSWORD="Mudar123"

# INSTALL N98 (MAGENTO1 CLI)
WORKDIR /n98
RUN wget https://files.magerun.net/n98-magerun.phar
RUN chmod +x ./n98-magerun.phar
RUN cp ./n98-magerun.phar /usr/local/bin/
RUN n98-magerun.phar --version

# GET MAGENTO FILES
WORKDIR /var/www/html
RUN rm -f * && mkdir tmp
WORKDIR /var/www/html/tmp
RUN ls -l
RUN wget -O magento-$MAGENTO_VERSION.zip https://codeload.github.com/OpenMage/magento-mirror/zip/$MAGENTO_VERSION
RUN wget https://ufpr.dl.sourceforge.net/project/mageloads/assets/1.9.2.4/magento-sample-data-1.9.2.4.tar.gz
RUN chmod -R 755 /app

# UNZIP MAGENTO
RUN unzip magento-$MAGENTO_VERSION.zip
RUN cp -a magento-mirror-$MAGENTO_VERSION/. /var/www/html
RUN ls

# UNZIP MAGENTO-SAMPLE-DATA
WORKDIR /var/www/html
RUN gunzip tmp/magento-sample-data-1.9.2.4.tar.gz; exit 0
RUN tar -xf tmp/magento-sample-data-1.9.2.4.tar -C tmp
RUN cp -rv tmp/magento-sample-data-1.9.2.4/* .

# CLEAR TMP FILES
RUN rm -rf tmp

# COPY SCRIPT TO SETUP MAGENTO
ENV IS_INITIALIZED=0
COPY scripts/supervisord-zmagento.conf /etc/supervisor/conf.d/supervisord-zmagento.conf
COPY scripts/setup-magento.sh /setup-magento.sh

# CLEAN
RUN apt purge && apt-get autoremove -y && apt-get clean

# EXPOSE AND RUN
EXPOSE 80 3306
CMD ["/run.sh"]