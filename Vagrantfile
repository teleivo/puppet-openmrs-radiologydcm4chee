# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  # Ports
  # tomcat port (openmrs)
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  # dcm4chee jboss/tomcat port
  config.vm.network "forwarded_port", guest: 8081, host: 8081
  config.vm.network "forwarded_port", guest: 8082, host: 8082
  # dcm4chee dicom server port
  config.vm.network "forwarded_port", guest: 11112, host: 8112
  # openmrs-module-radiologydcm4chee dicom server port
  config.vm.network "forwarded_port", guest: 11114, host: 8114
  # dcm4chee hl7 server port
  config.vm.network "forwarded_port", guest: 2575, host: 8115

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "3000"
  end

  # Install git, r10k
  config.vm.provision "shell" do |shell|
    shell.path = "bootstrap.sh"
  end
  # Deploy and apply puppet environment
  # pass git branch name of environment you want to deploy via args
  git_branch_name = `git rev-parse --abbrev-ref HEAD`
  config.vm.provision "shell" do |shell|
    shell.path = "puppet_deploy_apply.sh"
    shell.args = git_branch_name
  end
end
