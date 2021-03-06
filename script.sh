#!/bin/bash

# this script will install LAMP onthe ubuntu server machine

# clear the screen
clear

# Download and Install the Latest Updates for the OS
apt update

# install apache on the server
apt-get install apache2 -y 

# check the apache version
apache2 -v

# renaming the default index file and copying site files to document root
mv /var/www/html/index.html /var/www/html/index.html.bak
cp -rv sitefiles/* /var/www/html/


# Download and Install the Latest Updates for the OS
apt-get update && apt-get upgrade -y

# Set the Server Timezone to CST
echo "America/Chicago" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# Enable Ubuntu Firewall and allow SSH & MySQL Ports
ufw enable
ufw allow 22
ufw allow 80
ufw allow 3306

# Install essential packages
apt-get -y install zsh htop

# Install MySQL Server in a Non-Interactive mode. Default root password will be "root"
echo "mysql-server-5.6 mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server-5.6 mysql-server/root_password_again password root" | sudo debconf-set-selections
apt-get -y install mysql-server


# Run the MySQL Secure Installation wizard
mysql_secure_installation

sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /etc/mysql/my.cnf
mysql -uroot -p -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;'

# installng PHP
apt install php -y

# creating info.php page to check php working.
echo "<? phpinfo(); ?>" >> /var/www/html/info.php

# enabling and restarting the required services
service mysql restart
service apache2 start
service apache2 enable
service apache2 status

