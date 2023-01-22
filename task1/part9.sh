#!/bin/sh
#get list of logged users
loggedusers=$(users)

#get current date
currentdate=$(date +"%Y %m %d %H:%M")

#print on outputpart9.sh
echo "$currentdate: $loggedusers" >> /root/task1/outputpart9.txt

