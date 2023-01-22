#!/bin/sh
#open ports 80,443 tcp 
firewall-cmd --zone=public --add-port={443,80}/tcp
#making the changes permenant
firewall-cmd --permanent --zone=public --add-port={443,80}/tcp
#rejecting ip address 192.168.236.3 from sshing to this server
firewall-cmd --zone=public --add-rich-rule="rule family=ipv4 source address=192.168.236.3 port port=22 protocol=tcp reject"


