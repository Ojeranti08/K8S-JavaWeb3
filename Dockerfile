# Use an official Maven image as the build stage
FROM maven:3.8.3-openjdk-11-slim AS build

# Set the working directory in the container
WORKDIR /home/centos/K8S-JavaWeb3/src/main

# Copy the POM file and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the application source code
COPY src src

# Build the application
RUN mvn package

# Use an official Tomcat runtime as the base image
FROM tomcat:9.0-jdk11-openjdk-slim

# Set the working directory to the Tomcat webapps directory
WORKDIR /usr/local/tomcat/webapps

# Download and extract Nexus
RUN mkdir -p ${NEXUS_HOME} && \
    wget -O /tmp/nexus.tar.gz https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz && \
    tar -zxvf /tmp/nexus.tar.gz -C ${NEXUS_HOME} --strip-components=1 && \
    rm /tmp/nexus.tar.gz && \
    sed -i '/^#.*karaf./s/^#//' ${NEXUS_HOME}/bin/nexus.vmoptions

# Set environment variables for Nexus installation
ENV NEXUS_VERSION 3.38.0-01
ENV NEXUS_HOME /opt/sonatype/nexus

# Download the WAR file from Nexus and deploy it to Tomcat
RUN curl -o WebAppCal-0.0.6.war \
    http://52.204.135.48:8081/nexus/content/repositories/releases/com/web/cal/WebAppCal/0.0.6/WebAppCal-0.0.6.war

# Expose Nexus, Apache and Tomcat ports
EXPOSE 8081 80 8080 

# Start Nexus and Tomcat
CMD ${NEXUS_HOME}/bin/nexus run && ${CATALINA_HOME}/bin/catalina.sh run
