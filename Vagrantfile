#!/usr/bin/env ruby
Vagrant.configure("2") do |config|
  config.vm.define "jenkins" do |node|
    node.vm.box = "sbeliakou/centos-7.4-x86_64-minimal"
    node.vm.hostname = "jenkins"
    node.vm.network "private_network", ip: "192.168.56.2"
    node.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.name = "jenkins"
    end
    node.vm.provision "shell", path: "jserver.sh"
  end
end
