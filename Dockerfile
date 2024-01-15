# Use an official Tomcat runtime as the base image
FROM tomcat:latest

# Remove the existing contents of the Tomcat webapps directory
RUN rm -rf /usr/local/tomcat/webapps/*

# Set the working directory to /home/centos/K8S-JavaWeb3
WORKDIR /home/centos/K8S-JavaWeb3

# Copy the WAR file from the target directory to Tomcat webapps
COPY target/*.war /usr/local/tomcat/webapps/
