# QuarkusEnvironment
A Vagrantfile has been made available, to streamline the setup of a Quarkus Development environment by creating a Virtual Machine.

# Requirements

Download & Install Vagrant for you platform:  https://www.vagrantup.com/downloads.html

Download & Install VirtualBox: https://www.virtualbox.org/

Download & Install Git for Windows (mainly to use Git Bash):  https://gitforwindows.org/

Once done, from a Git Bash Shell, install Vagrant plug-in to enable VirtualBox Guest additions:
```shell script
vagrant plugin install vagrant-vbguest
```

This will enable some features like Host/Guest file sharing. 

The Vagrantfile has been tested on Windows 10 with Vagrant 2.2.7 and VirtualBox 6.1.2 r135662 (Qt5.6.2) and the virtual machine is reached through ssh from a Git Bash Shell. 

# Customization

You are invited to look at the Vagrantfile since it contains information you might want to customize. 

I.e. the port the service will be listening to is 8080 on the guest, but it is redirected on 8180 on the Host, to be able to run the server both on the Host and on the Guest at the same time without clashes.

# Usage

## Startup
Within the Vagrantfile directory run:
```shell script
vagrant up
```

The guest additions will be installed and the virtual machine will be provisioned. 

## Provisioning

Several tools will be installed to enable a smooth development experience (Java, Maven, Git, etc.). 

They will not be listed here for brevity, but can be found in:
```shell script
cat provision.sh
```

If for any reason the provision step would fail, you can simply run:
```shell script
vagrant up --provision
```
to trigger it again.

Also, this step (as well as the first start) involves several updates and it might take time depending on internet connection.

### Note about Java SDK version
Once provisioning completed, it could be needed to choose the JAVA SDK version to be used. 

For pokemon_challenge project it is OpenJDK 1.8.
```shell script
vagrant ssh

[vagrant@localhost ~]$ sudo update-alternatives --config java

There are 2 programs which provide 'java'.

  Selection    Command
-----------------------------------------------
*+ 1           java-1.8.0-openjdk.x86_64 (/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64/jre/bin/java)
   2           java-11-openjdk.x86_64 (/usr/lib/jvm/java-11-openjdk-11.0.8.10-0.el7_8.x86_64/bin/java)

Enter to keep the current selection[+], or type selection number: 1
```

#### Why OpenJDK 1.8 ?
This version is able to complete a Docker image build (which have been tested and working). 

It is still tolerated but deprecated, as a warning shows you during server start. 

#### Why OpenJDK 11 ?
This is the version that will be supported in the future and new projects should use this one.

However it seems as there are issues when using this version to build a Docker image with Maven and Quarkus Docker plugin.

### Note about Docker installation
Docker is installed using a convenience script, following [Docker official site guide](https://docs.docker.com/engine/install/centos/#install-using-the-convenience-script)

Reason is that it is the faster way to automate Docker installation however this is not suited for a Production environment and downloaded script should always be inspected before execution. 

## SSH connectiviy

To open a shell to the Virtual Machine once started: 
```shell script
vagrant ssh
```
## Source code 

The source code should normally be available under:
```shell script
cd /home/vagrant/workspace
```
And it should be mapped on src folder within this repository, in the Host.

From the virtual machine you should be able to clone the Pokemon Challenge repository as following:
```shell script
cd /home/vagrant/workspace
git clone https://github.com/fmelpignano/pokemon_challenge.git 
```

To know more about Pokemon Challenge project, please refer to its [README page](https://github.com/fmelpignano/pokemon_challenge/blob/main/README.md)

## Stop

To stop the virtual machine
```shell script
vagrant halt
```
