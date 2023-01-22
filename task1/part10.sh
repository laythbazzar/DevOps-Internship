#!/bin/sh
#to download mariadb, mysql should be uninstalled
#download the mariadb repository
wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
chmod +x mariadb_repo_setup
sh mariadb_repo_setup

#download the epel repository to download dependency pv for mariadb-server
yum install epel-release.noarch

#using epel repo can on centos can create a problem 
#it can be solved by using the base url insted of the mirrors in /etc/epel.repo
yum install pv
yum install mariadb

#open port 3306 for mariadb
firewall-cmd --add-port=3306/tcp
firewall-cmd --add-port=3306/tcp --permanent

#create database studentdb
mariadb -e "CREATE DATABASE studentdb"

#create user:layth and password:redhat
mariadb -e "CREATE USER layth@localhost IDENTIFIED BY 'redhat'"

#handle privileges on user: layth
mariadb -e "GRANT ALL PRIVILEGES on studentdb.* to layth@localhost IDENTIFIED BY 'redhat'"
mariadb -e "FLUSH PRIVILEGES"

#sign in from user:layth using password:redhat
mariadb -u layth -p

#createtable and insert into it
use studentdb;
CREATE TABLE students (firstname varchar(20), lastname varchar(20), program varchar(40) , expected_graduation_year int, student_num int primary key);
insert into students values ('Allen','Brown','mechinical',2017,110001),('David','Brown','mechanical',2017,110002),('Mary','Green','mechanical',2018,110003),
(Dennis,Green,electrical,2018,110004);
