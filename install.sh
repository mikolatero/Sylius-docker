#/bin/bash

## No ask when install from apt or deb
export DEBIAN_FRONTEND=noninteractive

## AUTOCONF MYSQL INSTALL ##
debconf-set-selections <<< 'mysql-server mysql-server/root_password password 1password'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 1password'

## INSTALL DEPENDENCIES ##
apt-get update
apt-get -f -y install php curl php7.0-cli git php7.0-zip php7.0-curl php7.0-mbstring php7.0-dom php7.0-gd php7.0-intl php7.0-mysql python-software-properties mysql-server unzip

curl -sL https://deb.nodesource.com/setup_6.x | bash -
apt-get update
apt-get -f -y install nodejs

sed 's/;date.timezone =/date.timezone = Europe\/Madrid/g' /etc/php/7.0/cli/php.ini > /tmp/php.ini
mv /tmp/php.ini /etc/php/7.0/cli/php.ini
/etc/init.d/mysql start
## CONFIGURE DATABASE FOR SYLIUS ##
mysql -u root -p1password -e 'create database sylius'
mysql -u root -p1password -e 'grant all privileges on sylius.* to "root"@"localhost" identified by ""';

## DOWNLOAD AND INSTALL SYLIUS ##
cd /opt/
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
composer --no-interaction create-project -s alpha sylius/sylius-standard sylius
cd /opt/sylius
npm install
npm run gulp
sed "s/question> ', false/question> ', true/g" vendor/sylius/sylius/src/Sylius/Bundle/CoreBundle/Command/InstallSampleDataCommand.php > /tmp/InstallSampleDataCommand.php
mv /tmp/InstallSampleDataCommand.php vendor/sylius/sylius/src/Sylius/Bundle/CoreBundle/Command/InstallSampleDataCommand.php
php app/console --no-interaction sylius:install
exit 0
