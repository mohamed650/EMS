# Stage 1: Build stage
FROM maven:3.8.4-openjdk-17-slim AS build
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn package -DskipTests

# Stage 2: Run stage
FROM tomcat:9-jdk17-openjdk-slim
COPY --from=build /target/ems-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]