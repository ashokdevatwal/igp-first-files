# Dockerfile
FROM tomcat:latest

# Set Java version to Java 11
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="$JAVA_HOME/bin:${PATH}"

# Install OpenJDK 11
RUN apt-get update && apt-get install -y curl \
    && curl -sL https://github.com/AdoptOpenJDK/openjdk11-upstream-binaries/releases/download/jdk-11.0.12%2B7/OpenJDK11U-jdk_x64_linux_11.0.12_7.tar.gz | tar xz -C /opt/java \
    && ln -s $JAVA_HOME /docker-java-home \
    && rm -rf /var/lib/apt/lists/*

# Copy the WAR file to the Tomcat server
COPY ./target/ABCtechnologies-1.0.war  /usr/local/tomcat/webapps/

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat when the container launches
CMD ["catalina.sh", "run"]
