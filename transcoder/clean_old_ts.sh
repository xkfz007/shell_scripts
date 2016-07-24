#!/bin/bash

sudo sed -i '/\/home\/ubuntu\/Documents\/clean_old_ts/d' /etc/crontab
echo "0 0 * * * root /home/ubuntu/Documents/clean_old_ts.sh" >> /etc/crontab

dir_list="/home/ubuntu/Documents/mlzg_list.txt"
while read line
do
   if [ ${#line} -eq 0 ];then
      continue
   fi
   line=${line#\ }
   line=${line%\ }
   first_char=${line:0:1}
   if [ $first_char == '#' ];then
      continue
   fi
   echo "DIR="$line
   find $line  -name "*.ts"  -mtime +3 -exec rm -rf {} \;
   find $line  -name "*.idx" -mtime +3 -exec rm -rf {} \;
done <"$dir_list"



