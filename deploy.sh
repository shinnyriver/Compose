#!/bin/bash

echo "🚀 배포 시작: $(date)"

cd ~/springboot-docker-compose || exit

# 최신 코드 가져오기
echo "📥 최신 코드 가져오기..."
git pull origin main

# ✅ .env 파일이 존재하는지 확인
if [ ! -f .env ]; then
    echo "❌ .env 파일이 존재하지 않습니다. 배포를 중단합니다."
    exit 1
fi

# ✅ Docker Hub에서 최신 이미지 가져오기
echo "🐳 최신 Docker 이미지 가져오기..."
source .env  # .env 파일 로드
docker pull $DOCKER_USERNAME/mysql:latest
docker pull $DOCKER_USERNAME/backend:latest
docker pull $DOCKER_USERNAME/nginx:latest

# ✅ 기존 컨테이너 중지 및 삭제
echo "🛑 기존 컨테이너 정리..."
docker-compose down

# ✅ 컨테이너 실행 (.env 파일 자동 로드)
echo "🚀 새로운 컨테이너 실행..."
docker-compose up -d --force-recreate --remove-orphans

# ✅ 불필요한 Docker 이미지 삭제
echo "🧹 사용하지 않는 Docker 이미지 정리..."
docker system prune -f

echo "✅ 배포 완료!"