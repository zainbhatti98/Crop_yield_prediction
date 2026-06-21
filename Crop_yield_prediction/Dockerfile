# Stage 1: Build the Maven application
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copy pom.xml and download dependencies to leverage Docker layer caching
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the source code and build the WAR package
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Deploy to Tomcat
FROM tomcat:10.1-jdk21
COPY --from=build /app/target/Crop_yield_prediction.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]