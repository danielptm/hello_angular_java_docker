FROM openjdk:11
USER root
#RUN apt-get bash
ARG JAR_FILE=target/HelloStandardBE-2.3.2.RELEASE.jar
COPY ${JAR_FILE} /app.jar
ENTRYPOINT ["java","-jar", "/app.jar"]
