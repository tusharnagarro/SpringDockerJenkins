FROM tomcat:alpine
MAINTAINER Tushar
WORKDIR $JENKINS_HOME/workspace/deployment_pipeline/
COPY SpringDockerJenkins.war /usr/local/tomcat/webapps/
RUN chmod -R 777 /usr/local/tomcat/webapps/SpringDockerJenkins.war
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
