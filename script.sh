#!/bin/bash
#this script will install apache onthe ubuntu server machine
# copy the files to the document root
# start the server
clear
echo "enter the server IP address:"
read ip
echo "the entered IP is : $ip"
apt update
apt-get install apache2 -y
apache2 -v
mv /var/www/html/index.html /var/www/html/index.html.bak
cp -rv sitefiles/* /var/www/html/

service apache2 start
service apache2 enable
service apache2 status

