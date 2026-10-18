#build stage
FROM maven:4.0.0-rc-7-eclipse-temurin-25-alpine AS build
ADD . /app
WORKDIR /app
RUN mvn package

#RUNTIME stage 
#in this stage java should be base image so eclipse temurin....
FROM eclipse-temurin:25-noble AS runtime
#label is metadata what this project or etc is
LABEL project=spc
LABEL author=devopsteam
#creating a user to protect jar file
RUN useradd -m -d /java -s /bin/bash devops 
#switching to devops user
USER devops
#creating directory to store jar file for security from hackers
WORKDIR /java
#copyig or sharing FROM TO FROM/HOSt TO HOST. here copying build from above FROM stage
COPY --from=build /app/target/*.jar naveen.jar
#telling port default port number of spc application
EXPOSE 8080
#cmd is defined for main command which runs application
CMD ["java", "-jar", "naveen.jar"]