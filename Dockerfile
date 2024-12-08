# Stage 1: Build the application
FROM maven:3.8.6-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN chmod +x ./mvnw && ./mvnw clean package -DskipTests

# Stage 2: Run the application
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/*.war /app/jpetstore.war

# Expose the port on which the application runs
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "/app/jpetstore.war"]
