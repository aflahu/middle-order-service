# Stage 1: Build artifact menggunakan Maven
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime image menggunakan JRE yang ringan
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Menambahkan user non-root demi alasan keamanan (Security Best Practice)
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copy jar dari stage 1
COPY --from=build /app/target/*.jar app.jar

# Ekspos port microservice (misal: 8080)
EXPOSE 8080

# Optimasi JVM untuk container (cgroup awareness)
ENTRYPOINT ["java", "-XX:+UseG1GC", "-jar", "app.jar"]