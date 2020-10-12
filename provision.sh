#!/usr/bin/env bash

echo "Updating CentOs"
sudo yum -y update

echo "Installing Base Tools"
# For Apache Maven
sudo yum install -y wget
sudo yum -y install unzip
# To create Git Repositories
sudo yum -y install git

echo "Installing OpenJdk 8"
sudo yum install  java-1.8.0-openjdk-devel

# Maven 3.6.3 and higher required to use Quarkus
echo "Installing Maven 3.6.3"
MVN_ZIP_FILE=/tmp/apache-maven-3.6.3-bin.tar.gz
if test -f "$MVN_ZIP_FILE"; then
    echo "$MVN_ZIP_FILE exists."
else
    sudo wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
fi

# Get the maven version currently installed, if it is not the expected (3.6.3), update it.
MVN_VERSION=`mvn -version | grep Apache | cut --delimiter=" " -f3`
if [ $MVN_VERSION = "3.6.3" ]; then
    echo "MVN 3.6.3 already installed, nothing to do."
else
    sudo tar xf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt
    sudo ln -s /opt/apache-maven-3.6.3 /opt/maven
    echo "Updating bash profile to use Maven 3.6.3"
    sudo echo "export M2_HOME=/opt/maven" >> /home/vagrant/.bash_profile
    sudo echo "export MAVEN_HOME=$M2_HOME" >> /home/vagrant/.bash_profile
    sudo echo "export PATH=$M2_HOME/bin:$PATH" >> /home/vagrant/.bash_profile
fi

# https://www.graalvm.org/docs/getting-started-with-graalvm/linux/