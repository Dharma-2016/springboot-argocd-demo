# -------- Stage 1 : Build Stage --------
FROM maven:3.9.9-eclipse-temurin-21 AS builder

WORKDIR /build

# Copy source code
COPY pom.xml .
COPY src ./src

# Build the jar
RUN mvn clean package -DskipTests


# -------- Stage 2 : Runtime Stage --------
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

# Copy jar from builder stage
COPY --from=builder /build/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
