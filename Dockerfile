# Use Maven to build the application
FROM maven:3.8-openjdk-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the project's pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the application and package it into a JAR file
RUN mvn clean package -DskipTests

# Use a smaller OpenJDK image to run the application
FROM openjdk:17-jdk-slim

# Set the working directory for the runtime environment
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/java-hello-world-1.0-SNAPSHOT.jar app.jar

# Expose the port if the application uses any specific port (optional)
# EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
