#!/bin/sh
#move /etc/fstab to /var/tmp and rename it to admin
cp /etc/fstab /var/tmp/admin

#modify the access list to allow user1 to read and write admin file while 
#user2 can't do anything 
setfacl -m u:user1:rw- /var/tmp/admin 
setfacl -m u:user2:--- /var/tmp/admin

