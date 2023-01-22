#!/bin/sh
#sh key pair on local machine type(-t) rsa new paraphrese(-N):empty
#storage file(-f) /root/.ssh/id_rsa
ssh-keygen -t rsa -N '' -f /root/.ssh/id_rsa

#upload key to remote server from input file(-i): /root/.ssh/id_rsa.pub
ssh-copy-id -i /root/.ssh/id_rsa 192.168.56.1 -p 49152 #replace ip with remote server ip

#ssh remote serevr using rsa key
ssh 192.168.56.1 -p 49152

