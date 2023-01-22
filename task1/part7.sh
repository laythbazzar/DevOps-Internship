#!/bin/sh
#install ymux and httpd
yum install tmux httpd

#install mysql repo to install mysql
rpm -Uvh https://repo.mysql.com/mysql80-community-release-el7-7.noarch.rpm
sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/mysql-community.repo
#install mysql
yum --enablerepo=mysql80-community install mysql-community-server

#start mysql then enabling it
systemctl start httpd
systemctl enable httpd

#install create repo and yum-utils to help making repos and managing it
yum install -y wget createrepo yum-utils

#creating dir /var/www/html/localrepo and downloading zabbix repo in it
mkdir /var/www/html/localrepo
wget --no-parent -r  http://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/ -P /var/www/html/localrepo

#creating repo
createrepo /var/www/html

#adding repo from httpd
yum-config-manager --add-repo http://192.168.236.4/

#making the repo download without checking gpg keys
vim /etc/yum.repos.d/192.168.236.4_.repo
#gpgcheck=0
#
#

yum clean all

#downloading dependencies then adding the dependencies to the repo
# update option could be used instead of just recreating it
yum install --downloadonly --downloaddir=/var/www/html/localrepo/deps zabbix-web zabbix-agent zabbix-server
yum install --downloadonly --downloaddir=/var/www/html/localrepo/deps OpenIPMI-libs php php-devel php-bcmath php-pear php-gd php-mbstring php-mysql php-xml
createrepo /var/www/html
yum clean all
yum makecache

#disabling all repos then enabling created repo to download zabbix web, agent and server
yum-configure-manager --disable \*
yum-configure-manager --enable 192.168.1.16_
yum install zabbix-web zabbix-agent zabbix-server
