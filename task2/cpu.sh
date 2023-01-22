#!/bin/sh

#store date in variable d
d=$(date +"%Y-%m-%d-%H:%M")

#make data dir if not founded
if [[ ! -d data ]]; then   mkdir data; fi

#write data on CPUDataLog and on CPU.{date}
echo "   <p>-------------------------------------<p>" >> data/CPUDataLog
echo "   <p>$d<p>" >> data/CPUDataLog
mpstat -P ALL |awk 'NR>1 {printf"\t<p> %s\t %s <p>\n",$3,$4}'>> data/CPUDataLog
mpstat -P ALL |awk 'NR>1 {printf"%-10s %-10s\n",$3,$4}'>> data/CPU.$d

#copy header to CPU.html file
cp header.html /var/www/html/CPU.html

#print average after header
cat data/CPUDataLog| grep all |awk 'BEGIN {availSum=0.0;counter=0} {usedSum=usedSum+$3;counter=counter+1} END {printf"\t<p> average CPU usage:  %s%  <p>\n",usedSum/counter}'>> /var/www/html/CPU.html

#write data from CPUDataLog to CPU.html
cat data/CPUDataLog >> /var/www/html/CPU.html

#close opened tags
echo "</body>" >>/var/www/html/CPU.html
echo "</html>" >>/var/www/html/CPU.html
