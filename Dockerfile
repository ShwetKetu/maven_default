FROM tomcat:9.0
LABEL maintainer="Shwet Ketu"
RUN cd /opt/jenkins/maven_default
ADD ROOT.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]