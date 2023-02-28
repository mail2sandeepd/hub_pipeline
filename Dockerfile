FROM tomcat:latest
COPY helloworld.war /usr/local/tomcat/webapps/ROOT.war
RUN sed -i 's/Connector port="8080"/Connector port="4000"/' /usr/local/tomcat/conf/server.xml
EXPOSE 4000
CMD ["catalina.sh", "run"]
