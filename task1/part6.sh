#!/bin/sh
#create a command that keeps running in the background for 10 mins
sleep 600& #600 seconds=10 mins
ps -aux |grep -w 'sleep'
#get the id of sleep from active processes
id=$(ps -u|grep -w 'sleep 600'|awk '(NR==1){print $2}')
#print id of process then kill it

echo "id is $id"
kill -9 $id

