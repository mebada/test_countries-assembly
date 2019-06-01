#!/bin/bash

set -e

echo 1 > mytestfile

while [ "`cat mytestfile`" = 1 ]
do
  response=`curl -s -o /dev/null -I -w "%{http_code}" http://localhost:8080/health/ready`
  if [ "$response" == "200" ];then 
    exit 0
   elif [ "$response" == "503" ];then 
     sleep 10
   else
     exit 1
   
 fi    

done

status=`cat mytestfile`
exit $status

