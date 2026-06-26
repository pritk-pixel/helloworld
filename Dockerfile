# Build stage
FROM --platform=linux/amd64 maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -q
COPY src ./src
RUN mvn package -q -DskipTests

# Run stage
FROM --platform=linux/amd64 eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/helloworld.jar helloworld.jar
ENTRYPOINT ["java", "-jar", "helloworld.jar"]
