
# To install Virtual Box Guest Additions in CentOs
# vagrant plugin install vagrant-vbguest

Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.box = "centos/7"

  config.vm.network "private_network", type: "dhcp"
  config.vm.network "forwarded_port", guest: 8080, host: 8180
  config.vm.synced_folder "./src", "/home/vagrant/workspace/truelayer"
  
  config.vm.provider "virtualbox" do |v|
    v.name = "truelayer_11"
    v.memory = "2048"
    v.cpus = "2"
  end
  config.vm.provision :shell, path: "provision.sh"
end

