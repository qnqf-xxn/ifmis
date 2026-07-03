#!/bin/bash
i=0 
for x in `ps -ef | grep java | grep /ifmis- |awk '{print $2}'` 
do 
kill -9 "$x" 
let "i++" 
done 
docker-compose stop
if [ $i -eq 0 ]; then 
echo "No Running microservice Instance Found!" 
else 
echo "microservice already shutdown successfully!" 
fi 







