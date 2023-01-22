#!/bin/sh

#write currently assigned crons to cron.tmp file
crontab -l > cron.tmp

#make crontab to run cpu.sh, disk.sh and memory.sh every hour
echo "0 * * * * sh task2/cpu.sh" >> cron.tmp
echo "0 * * * * sh task2/disk.sh" >> cron.tmp
echo "0 * * * * sh task2/memory.sh" >> cron.tmp
crontab cron.tmp

#delete cron.tmp file
rm cron.tmp
