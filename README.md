# :wqTest

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

Also, this step (as well as the first start) involves several updates aand might take time depending on internet connection. 

## SSH connectiviy

To open a shell to the Virtual Machine once started: 
```shell script
vagrant ssh
```
## Source code and compilation

The source code should normally be available under:
```shell script
cd /home/vagrant/workspace
```
And it should be mapped on src folder within this repository, in the Host.

## Stop

To stop the virtual machine
```shell script
vagrant halt
```
