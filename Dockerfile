FROM maven:4.0.0-rc-7-eclipse-temurin-25-alpine AS build
ADD . /app
WORKDIR /app
RUN mvn package

FROM eclipse-temurin:25-noble AS runtime
COPY --from=build /app/target/*.jar naveen.jar
EXPOSE 8080
CMD ["java", "-jar", "naveen.jar"]