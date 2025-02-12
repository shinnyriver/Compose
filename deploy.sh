#!/bin/bash

echo "Initiate Deploy: $(date)"

cd ~/springboot-docker-compose || exit

git pull origin main

docker-compose down

docker-compose up --build -d

docker system prune -f

echo "Deploy Complete: $(date)"