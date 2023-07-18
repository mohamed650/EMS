FROM maven:3.8.3-eclipse-termurin-17-alpine AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17
COPY --from=build /target/ems.war ems.war

EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "ems.jar" ]