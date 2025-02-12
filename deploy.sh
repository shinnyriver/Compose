#!/bin/bash

echo "🚀 배포 시작: $(date)"

cd ~/springboot-docker-compose || exit

# 최신 코드 가져오기
git pull origin main

# ✅ Gradle 빌드 실행 (JAR 파일 생성)
cd backend
./gradlew clean build -x test
cd ..

# 기존 컨테이너 중지 및 삭제
docker-compose down


docker-compose up --build -d

# 불필요한 Docker 이미지 삭제
docker system prune -f

echo "✅ 배포 완료: $(date)"