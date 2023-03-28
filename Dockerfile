# Stage 1: Build the application
FROM maven:3.6.3-openjdk-17 as build
COPY src /usr/home/api-gateway/src
COPY ./pom.xml /usr/home/api-gateway
RUN mvn -f /usr/home/api-gateway/pom.xml clean package -DskipTests

# Stage 2: Package the application
FROM openjdk:17-jdk
COPY --from=build /usr/home/api-gateway/target/*.jar /api-gateway.jar
EXPOSE 8082
ENTRYPOINT ["java","-jar","/api-gateway.jar"]