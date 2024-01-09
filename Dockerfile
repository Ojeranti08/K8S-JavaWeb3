FROM openjdk:11

# Set working directory
WORKDIR /home/centos/K8S-JavaWeb3

# Copy JAR file into the image
COPY target/WebAppCal-0.0.6.war /home/centos/K8S-JavaWeb3/app.jar

# Add Kubernetes configuration files
ADD k8s-javaweb3-deployment.yaml  app-config.yaml

EXPOSE 80

# Command to run the application
# Set the entry point
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar", "server", "app-config.yaml"]
