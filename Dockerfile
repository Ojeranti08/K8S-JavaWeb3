# Use an official Tomcat runtime as the base image
FROM tomcat:latest
RUN rm -rf /usr/local/tomcat/webapps/*

WORKDIR /home/centos/K8S-JavaWeb3
COPY target/*.war /home/centos/apache-tomcat-7.0.94/webapps/

# Set the working directory to the Tomcat webapps directory
WORKDIR /home/centos/apache-tomcat-7.0.94/webapps/

# Expose Nexus, Apache and Tomcat ports
EXPOSE 8080 

# Start Nexus and Tomcat
CMD ${CATALINA_HOME}/bin/catalina.sh run
