# Maven build container 

FROM maven:3.8.5-openjdk-17 AS maven_build

COPY pom.xml /tmp/

COPY src /tmp/src/

WORKDIR /tmp/
RUN ["mvn", "package", "-Dmaven.test.skip=true"]

#RUN mvn package -Dmaven.test.skip=true

#pull base image

FROM eclipse-temurin:17-jdk-alpine

#maintainer 
MAINTAINER gyanendu8191@gmail.com
#expose port 8080
EXPOSE 8080

#default command
CMD java -jar /data/MicroService3-0.0.1-SNAPSHOT.jar

#copy hello world to docker image from builder image

COPY --from=maven_build /tmp/target/MicroService3-0.0.1-SNAPSHOT.jar /data/MicroService3-0.0.1-SNAPSHOT.jar