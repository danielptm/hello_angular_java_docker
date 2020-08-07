FROM openjdk:11
USER root
#RUN apt-get bash
ARG JAR_FILE=target/HelloStandardBE2-2.3.2.RELEASE.jar
COPY ${JAR_FILE} /app2.jar
ENTRYPOINT ["java","-jar", "/app2.jar"]
