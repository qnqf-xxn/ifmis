#!/bin/bash
i=0 
for x in `ps -ef | grep java | grep /ifmis- |awk '{print $2}'` 
do 
kill -9 "$x" 
let "i++" 
done 
docker-compose stop
if [ $i -eq 0 ]; then 
echo ----------------------------------------
echo "No Running microservice Instance Found!" 
else 
echo ----------------------------------------
echo "microservice already shutdown successfully!" 
fi 
sleep 3s
echo ----------------------------------------
echo starting servers! wait for moment ...... 
echo ----------------------------------------
nohup docker-compose up &>nohup.out &
sleep 60s
nohup docker-compose -f ./services/docker-compose.yml up &>nohup-services.out &
sleep 3s
nohup docker-compose -f ./public/docker-compose.yml up &>nohup-public.out &
sleep 3s
nohup docker-compose -f ./pdm/docker-compose.yml up &>nohup-pdm.out &
sleep 3s
nohup docker-compose -f ./bdm/docker-compose.yml up &>nohup-bdm.out &
sleep 3s
nohup docker-compose -f ./bdg/docker-compose.yml up &>nohup-bdg.out &
sleep 3s
nohup docker-compose -f ./pmkpi/docker-compose.yml up &>nohup-pmkpi.out &
sleep 3s
echo servers started ...... 
echo ----------------------------------------
sleep 3s
docker images | grep  none
if [ $? -eq 0 ]; then 
docker rmi `docker images | awk '/^<none>/{print $3}'`
echo ----------------------------------------
echo delete none images over
echo ----------------------------------------
fi
sleep 3s
docker-compose ps
docker-compose -f ./services/docker-compose.yml ps
docker-compose -f ./public/docker-compose.yml ps
docker-compose -f ./pdm/docker-compose.yml ps
docker-compose -f ./bdm/docker-compose.yml ps
docker-compose -f ./bdg/docker-compose.yml ps
docker-compose -f ./pmkpi/docker-compose.yml ps
