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
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
  
    # Customize the amount of memory on the VM:
    vb.memory = "3560"
  end

  # Install librarian-puppet and necessary puppet modules
  config.vm.provision "shell" do |shell|
    shell.path = "bootstrap.sh"
  end

  # Install/Configure dcm4chee/openmrs via puppet
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "site.pp"
    puppet.hiera_config_path = "hiera.yaml"
    puppet.module_path = 'modules'
  end
end
