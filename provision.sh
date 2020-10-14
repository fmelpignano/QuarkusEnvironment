#!/usr/bin/env bash

if [ ! -f "$QUARKUS_ENV_FILE" ]; then
    sh /etc/profile.d/env_vars_quarkus.sh
fi

echo "Updating CentOs"
sudo yum -y update

echo "Installing Base Tools"
# repositories and certificates
sudo yum install -y epel ca_certificates
# Nestat, traceroute and nslookup
sudo yum install -y net-tools traceroute bind-utils
# For later testing 
sudo yum install -y httpie
# Install mvn base (3.0.5) version
sudo yum install -y maven

# For Apache Maven
sudo yum install -y wget
sudo yum -y install unzip
# To create Git Repositories
sudo yum -y install git

echo "Installing OpenJdk 1.8"
sudo yum install -y java-1.8-openjdk-devel

# Maven 3.6.3 and higher required to use Quarkus
echo "Installing Maven 3.6.3"
MVN_ZIP_FILE=/tmp/apache-maven-3.6.3-bin.tar.gz
if test -f "$MVN_ZIP_FILE"; then
    echo "$MVN_ZIP_FILE exists."
else
	# --no-check-certificate because behind a proxy, it should not be needed
    sudo wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp --no-check-certificate
fi

# Get the maven version currently installed, if it is not the expected (3.6.3), update it.
MVN_VERSION=`mvn -version | grep Apache | cut --delimiter=" " -f3`
if [ $MVN_VERSION = "3.6.3" ]; then
    echo "MVN 3.6.3 already installed, nothing to do."
else
    sudo tar xf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt
    sudo ln -s /opt/apache-maven-3.6.3 /opt/maven
	export M2_HOME=/opt/maven
fi

QUARKUS_ENV_FILE=/etc/profile.d/env_vars_quarkus.sh
if [ ! -f "$QUARKUS_ENV_FILE" ]; then
    echo "$QUARKUS_ENV_FILE does not exist."
	sudo bash -c 'cat <<EOF > /etc/profile.d/env_vars_quarkus.sh
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64/
export PATH=\$PATH:\$JAVA_HOME/bin
export M2_HOME=/opt/maven
export MAVEN_HOME=$M2_HOME
export PATH=$M2_HOME/bin:$PATH
EOF'
fi

# For Docker image generation
# https://docs.docker.com/engine/install/centos/#install-using-the-convenience-script
# Not for production purpose! 
curl -fsSL https://get.docker.com/ | sh
sudo systemctl start docker
sudo systemctl status docker
sudo systemctl enable docker

# https://www.graalvm.org/docs/getting-started-with-graalvm/linux/
