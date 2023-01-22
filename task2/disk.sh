#!/bin/sh

#store date in variable d
d=$(date +"%Y-%m-%d-%H:%M")

#mkae dir data if not founded
if [[ ! -d data ]]; then  mkdir data; fi

#write data on DiskDataLog
echo "   <p>-------------------------------------<p>" >> data/DiskDataLog
echo "   <p>$d<p>" >> data/DiskDataLog
df -m --total |awk '{printf"\t<p> %s\t %s\t %s <p>\n",$1,$3,$4}'>> data/DiskDataLog
df -m --total |awk '{printf"%-30s%-15s%-15s\n",$1,$3,$4}'>> data/disk.$d

# copy header from header.html to Disk.html
cp header.html /var/www/html/Disk.html

# print averages after header
cat data/DiskDataLog| grep total |awk 'BEGIN {usedSum=0;availSum=0;counter=0} {usedSum=usedSum+$3;availSum=availSum+$4;counter=counter+1} END {printf"\t<p> average used: %s\t average free: %s <p>\n",usedSum/counter,availSum/counter}'>> /var/www/html/Disk.html

# write data on Disk.html from DiskDataLog
cat data/DiskDataLog >> /var/www/html/Disk.html

#close opened tags in Disk.html
echo "</body>" >>/var/www/html/Disk.html
echo "</html>" >>/var/www/html/Disk.html
