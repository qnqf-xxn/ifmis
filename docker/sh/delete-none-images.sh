#!/bin/bash
docker images | grep  none
if [ $? -eq 0 ]; then 
docker rmi `docker images | awk '/^<none>/{print $3}'`
echo ----------------------------------------
echo delete none images over
echo ----------------------------------------
else 
echo ----------------------------------------
echo nothing to do
echo ----------------------------------------
fi