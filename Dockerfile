# Compile the JAR file
FROM maven:latest

COPY . /code
WORKDIR /code

RUN mvn clean package -DskipTests
RUN ls -lia target

# Load the JAR file and run it
FROM openjdk:8-jre-alpine

COPY --from=0 /code/target/*-dirty.jar /usr/src/server/server.jar
WORKDIR /usr/src/server
CMD ls -lia
CMD java -jar server.jar env.yml server.yml
