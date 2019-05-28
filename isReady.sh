#!/bin/bash

set -e

while :
do
  response=curl -s -o /dev/null -I -w "%{http_code}" http://localhost:8080/health/ready
  if [ $response =="200" ];then
     return 0
   elif [ $response =="503" ];then 
     sleep 10
     continue
   else
     return 1
 fi    
done



