FROM openjdk:11.0.21-jre
COPY target/WEB-INF/lib/servlet-api-2.5.jar /home/centos/K8S-JavaWeb3
WORKDIR /home/centos/K8S-JavaWeb3
ADD k8s-javaweb3-service.yaml app-config.yaml
CMD ["java", "-jar", "servlet-api-2.5.jar"]