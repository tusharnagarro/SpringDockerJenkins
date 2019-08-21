FROM tomcat:alpine
MAINTAINER Tushar
COPY ./target/SpringDockerJenkins.war /usr/local/tomcat/webapps/
RUN chmod -R 777 /usr/local/tomcat/webapps/SpringDockerJenkins.war
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
