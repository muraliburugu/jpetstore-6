FROM maven:3.8.7-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN chmod +x ./mvnw && ./mvnw clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/*.war /app/jpetstore.war

EXPOSE 8080
CMD ["java", "-jar", "/app/jpetstore.war"]
