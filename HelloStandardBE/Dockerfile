FROM maven:3.6.3-jdk-8 as maven
USER root

# copy the project files
COPY ./pom.xml ./pom.xml

# build all dependencies for offline use
RUN mvn dependency:go-offline -B

# copy your other files
COPY ./src ./src

RUN mvn package

# our final base image
FROM openjdk:8-jre-alpine

# set deployment directory
WORKDIR /app

# copy over the built artifact from the maven image
COPY --from=maven ./target/HelloStandardBE-*.jar /app/.

ENTRYPOINT ["java","-jar", "/app/HelloStandardBE-0.0.1.jar"]
