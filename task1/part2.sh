#!/bin/sh 
#Add user1, uid=601, password=redhat,shel non-interactive(/sbin/nologin) command useradd, options: -p password, -u: user id, -s:shell
useradd -u 601 -p redhat -s /sbin/nologin user1

#create group:TrainingGroup
groupadd TrainingGroup

#modify user1: append a suplementary group TrainingGroup
usermod -a -G TrainingGroup user1

#create group admin, password: redhat, create users: user2,user3 , group:admin, password:redhat
groupadd -p redhat admin 
adduser user2 -g admin -p redhat 
adduser user3 -g admin -p redhat

#give user3 root permission: set root group as suplementary group
usermod -a -G root user3


