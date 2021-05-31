#require 'yaml'
#settings = YAML.load_file("config.yml")


Vagrant.configure("2") do |config|

#jenkins vm
  config.vm.define "jenkins" do |jenkins|
  jenkins.vm.box = "bento/ubuntu-20.04"
  jenkins.vm.define "jenkins"
  jenkins.vm.hostname = "jenkins"
  jenkins.vm.network "forwarded_port", guest: 8080, host: 8080
#  jenkins.vm.network "private_network", ip: "192.168.33.10"
  jenkins.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = 2
    vb.memory = 4096
  end
  jenkins.vm.provision "shell" do |shell|
    shell.path = "jenkins_install.sh"
  end
  jenkins.vm.provision "shell" do |shell|
    shell.path = "docker_install.sh"
  end

  end
#web vm
  config.vm.define "web" do |web|
  web.vm.box = "bento/ubuntu-20.04"
  web.vm.define "web"
  web.vm.hostname = "web"
  web.vm.network "private_network", ip: "192.168.33.11"
  web.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = 2
    vb.memory = "2048"
  end
   web.vm.provision "shell" do |shell|
    shell.path = "docker_install.sh"
  end
  end


end
