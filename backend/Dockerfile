FROM openjdk:17-alpine

WORKDIR /app

# JAR 파일을 복사할 때, Gradle 빌드 경로를 올바르게 지정
ARG JAR_FILE=backend/build/libs/*.jar
COPY ${JAR_FILE} app.jar

CMD ["java", "-jar", "app.jar"]