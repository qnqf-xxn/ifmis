#!/bin/bash
clear
docker-compose ps
docker-compose -f ./services/docker-compose.yml ps
docker-compose -f ./public/docker-compose.yml ps
docker-compose -f ./pdm/docker-compose.yml ps
docker-compose -f ./bdm/docker-compose.yml ps
docker-compose -f ./bdg/docker-compose.yml ps
docker-compose -f ./pmkpi/docker-compose.yml ps