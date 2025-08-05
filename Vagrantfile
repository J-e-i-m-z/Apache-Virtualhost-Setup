# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Use CentOS 7 (you can change to CentOS 8 if preferred)
  config.vm.box = "almalinux/8"

  # Set hostname
  config.vm.hostname = "prod-web-server"

  # Create a private network (bridged would be better for real production)
  config.vm.network "private_network", ip: "192.168.56.1"

  # Forward port 80 for web access
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true

  # Provider-specific configuration
  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = "1024"
    vb.cpus = 2
    vb.name = "prod-web-server"
  end
end


