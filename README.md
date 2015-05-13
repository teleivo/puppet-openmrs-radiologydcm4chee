# puppet-openmrs-radiologydcm4chee

####Table of Contents

1. [Overview](#overview)
2. [Project Description - What the project does and why it is useful](#project-description)
3. [Setup - The basics of getting started](#setup)
    * [Setup requirements](#setup-requirements)
    * [How to get started](#how-to-get-started)
    * [How to speed up recreating a fresh VM](#how-to-speed-up-recreating-a-fresh-vm)
4. [Limitations](#limitations)

##Overview

Puppet/vagrant project to automatically create required infrastructure for [OpenMRS] (http://openmrs.org/), [dcm4chee] (http://www.dcm4che.org/) and [openmrs-module-radiologydcm4chee] (https://github.com/openmrs/openmrs-module-radiologydcm4chee)

##Project Description

This project is a collection of scripts which help you to provision a server running dcm4chee and OpenMRS.

The goal is to ease development and help get people started with the OpenMRS module [openmrs-module-radiologydcm4chee] (https://github.com/openmrs/openmrs-module-radiologydcm4chee) a module adding RIS capabilities to OpenMRS.

The provisioning of openmrs and dcm4chee is done by the following custom puppet modules:
* [teleivo/dcm4chee] (https://github.com/teleivo/puppet-dcm4chee)
* [teleivo/tomcat6] (https://github.com/teleivo/puppet-tomcat6)
* [teleivo/openmrs] (https://github.com/teleivo/puppet-openmrs)

##Setup

###Setup requirements

To get started you need to install:
* [virtualbox](https://www.virtualbox.org/)
* [vagrant](https://www.vagrantup.com/downloads.html)

###How to get started
To setup a virtual machine with OpenMRS and dcm4chee execute:
```
git clone https://github.com/teleivo/puppet-openmrs-radiologydcm4chee.git
cd puppet-openmrs-radiologydcm4chee
vagrant up
```

This will download a virtualbox VM with Ubuntu 14.04 64bit, install all necessary puppet modules via librarian-puppet and run the manifest/site.pp which
* installs mysql server
* installs [dcm4chee] (http://www.dcm4che.org/) and deploys DICOM viewer [weasis] (https://github.com/nroduit/Weasis)
* installs tomcat 6 and [OpenMRS] (http://openmrs.org/) version 1.9.7

####Access OpenMRS and dcm4chee
Once vagrant is done with the installation of the VM you can access the following via your browser:
* OpenMRS
 * [localhost:8080/openmrs/](http://localhost:8080/openmrs/)
* dcm4chee (user/password admin/admin)
 * web-interface for PACS images and worklist [localhost:8081/dcm4chee-web3/](http://localhost:8081/dcm4chee-web3/)
 * web-interface for configuration [localhost:8081/jmx-console/](http://localhost:8081/jmx-console/)

Or ssh into the virtual machine with
```
vagrant ssh
```

####Final configurations
A few things are still needed to integrate OpenMRS with dcm4chee:
* OpenMRS
 * run through the [OpenMRS](http://localhost:8080/openmrs/) wizard to finish the OpenMRS installation
 * [download](https://wiki.openmrs.org/display/docs/Radiology+Module+with+dcm4chee) and deploy [openmrs-module-radiologydcm4chee] (https://github.com/openmrs/openmrs-module-radiologydcm4chee) in OpenMRS
 
 Please go to https://wiki.openmrs.org/display/docs/Radiology+Module+with+dcm4chee to download the OpenMRS module and to get instructions on how to configure [openmrs-module-radiologydcm4chee] (https://github.com/openmrs/openmrs-module-radiologydcm4chee)

* dcm4chee
 * configure weasis as the web viewer at [localhost:8081/jmx-console/](http://localhost:8081/jmx-console/) section **dcm4chee.web, service=WebConfig** set
   - WebviewerNames= *weasis*
    - WebviewerBaseUrls= *weasis:/weasis-pacs-connector/viewer-applet*
 * add the radiology module as DICOM Application Entity at [localhost:8081/dcm4chee-web3/](http://localhost:8081/dcm4chee-web3/)
 * configure DICOM MPPS message forwarding to the OpenMRS radiology module at [localhost:8081/jmx-console/](http://localhost:8081/jmx-console/) section **dcm4chee.archive, service=MPPSScu**

####Important notes for Windows

[librarian-puppet](https://github.com/rodjek/librarian-puppet) which is used to install all required puppet modules
creates a highly nested structure in .tmp which might exceed the windows path
limit of 260 characters. So please make sure to clone this project to a shorter
path. See [issue](https://github.com/rodjek/librarian-puppet/issues/256) for further details

###How to speed up recreating a fresh VM
Once you have completed all steps in [How to get started](#how-to-get-started) its a good idea to create your own custom vagrant box.
This will allow you to quickly recreate a fresh VM without having to go through all the installation and configuration again :)

So make sure you have fully completed the setup as described above and issue the following commands
```
vagrant package --output openmrs-radiologydcm4chee.box
vagrant box add openmrs-radiologydcm4chee openmrs-radiologydcm4chee.box
```

To setup a new VM using your custom box go to a new directory and execute
```
vagrant init openmrs-radiologydcm4chee
```

##Limitations

Currently you will only be able to run this on a machine providing support for 64bit virtualization which is due to the puppet module [teleivo/dcm4chee] (https://github.com/teleivo/puppet-dcm4chee).
