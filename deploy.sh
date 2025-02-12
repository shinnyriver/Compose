#!/bin/bash

echo "🚀 배포 시작: $(date)"

cd ~/springboot-docker-compose || exit

# 최신 코드 가져오기
git pull origin main

# 기존 컨테이너 중지 및 삭제
docker-compose down
echo "DOCKER_USERNAME=${DOCKER_USERNAME}" > .env
echo "SPRING_DATASOURCE_URL=${SPRING_DATASOURCE_URL}" >> .env
echo "SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME}" >> .env
echo "SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD}" >> .env

# ✅ Docker Hub에서 최신 이미지 가져오기
docker pull $DOCKER_USERNAME/mysql:latest
docker pull $DOCKER_USERNAME/backend:latest
docker pull $DOCKER_USERNAME/nginx:latest
# ✅ 컨테이너 실행
docker-compose up -d

# 불필요한 Docker 이미지 삭제
docker system prune -f