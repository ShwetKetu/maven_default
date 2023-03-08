FROM tomcat:9.0
LABEL maintainer="Shwet Ketu"

ADD /var/lib/jenkins/workspace/meven_default/target/sample.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]
