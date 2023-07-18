# Stage 1: Build stage
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn package -DskipTests

# Stage 2: Run stage
FROM openjdk:17-slim
COPY --from=build /app/target/ems.jar /app/ems.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/ems.jar"]