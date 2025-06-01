# Build stage: Use Maven 3.9.6 with OpenJDK 17
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Run stage: Use Tomcat 10 with JDK 17 (Tomcat 9 also works, but 10 is better for new projects)
FROM tomcat:10.1.20-jdk17-temurin

# Optional: Adjust permissions if needed
RUN chmod -R 777 /usr/local/tomcat/conf

# Deploy WAR file
COPY --from=build /app/target/helloworld-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/helloworld.war
