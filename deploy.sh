#!/bin/bash

echo "🚀 배포 시작: $(date)"

cd ~ || exit

# ✅ 우분투 컨테이너가 실행 중인지 확인
if [ ! "$(docker ps -q -f name=ubuntu-container)" ]; then
    echo "⚠️ 우분투 컨테이너가 실행되지 않음. 새 컨테이너 생성!"
    docker run -dit --name ubuntu-container --privileged --restart always ubuntu:latest bash
fi

# ✅ 우분투 컨테이너 내부에 배포 스크립트 복사
docker cp ~/springboot-docker-compose ubuntu-container:/home/

# ✅ 우분투 컨테이너에서 배포 실행
docker exec -it ubuntu-container bash -c "
    cd /home/springboot-docker-compose &&
    git pull origin main &&
    docker-compose down &&
    docker-compose pull &&
    docker-compose up -d &&
    docker system prune -f
"

echo "✅ 배포 완료: $(date)"