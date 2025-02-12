#!/bin/bash

echo "Initiate Deploy: $(date)"

cd ~/springboot-docker-compose || exit

git pull origin main

cd backend
./gradlew clean build
cd ..

docker-compose down

docker-compose up --build -d

echo "Deploy Complete: $(date)"