FROM openjdk:11

# Copy JAR file into the image
COPY target/WEB-INF/lib/servlet-api-2.5.jar /home/centos/K8S-JavaWeb3

# Set working directory
WORKDIR /home/centos/K8S-JavaWeb3

# Add Kubernetes configuration files
ADD k8s-javaweb3-service.yaml app-config.yaml

EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "servlet-api-2.5.jar"]
