#!/bin/sh

#store date in variable d
d=$(date +"%Y-%m-%d-%H:%M")


#make data dir if not founded
if [[ ! -d data ]]; then  mkdir data; fi

#write data on MemoryDataLog
echo "   <p>-------------------------------------<p>" >> data/MemoryDataLog
echo "   <p>$d<p>" >> data/MemoryDataLog
free -m --total |awk '{printf"\t<p> %s\t %s\t %s <p>\n",$1,$2,$3}'>> data/MemoryDataLog
free -m --total |awk '{printf"%-10s %-10s %-10s\n",$1,$2,$3}'>> data/memory.$d

#copy header to Memory.html file
cp header.html /var/www/html/Memory.html

#print average after header
cat data/MemoryDataLog| grep Total |awk 'BEGIN {usedSum=0;availSum=0;counter=0} {usedSum=usedSum+$3;availSum=availSum+$4;counter=counter+1} END {printf"\t<p> average used:  %s\t average free: %s <p>\n",usedSum/counter,availSum/counter}'>> /var/www/html/Memory.html

#write data from MemoryDataLog to Memory.html
cat data/MemoryDataLog >> /var/www/html/Memory.html

#close opened tags in Memory.html
echo "</body>" >>/var/www/html/Memory.html
echo "</html>" >>/var/www/html/Memory.html
