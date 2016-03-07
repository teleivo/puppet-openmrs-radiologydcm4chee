# puppet-openmrs-radiologydcm4chee

**IMPORTANT NOTE: DICOM Wado + Weasis wont work right away**

Since server `http://dicom.vital-it.ch:8087` is currently down libclib_jiio.so cannot automatically be exchanged for you.
DICOM wado and thus opening images with weasis will not work from the start.
Please exchange libclib_jiio.so yourself if you have it, otherwise follow *8. Mac OSX and Windows x64 specific changes for the WADO service* at https://dcm4che.atlassian.net/wiki/display/ee2/Installation/



####Table of Contents

1. [Overview](#overview)
2. [Project Description - What the project does and why it is useful](#project-description)
3. [Setup - The basics of getting started](#setup)
    * [Setup requirements](#setup-requirements)
    * [How to get started](#how-to-get-started)
    * [How to speed up recreating a fresh VM](#how-to-speed-up-recreating-a-fresh-vm)
4. [Limitations](#limitations)
5. [Development](#development)
6. [Further reading](#further-reading)

##Overview

Puppet control repository including vagrant to automatically create required infrastructure for [OpenMRS] (http://openmrs.org/), [dcm4chee] (http://www.dcm4che.org/) and [openmrs-module-radiology] (https://github.com/openmrs/openmrs-module-radiology)

##Project Description

This project is a puppet control repository using [r10k] (https://github.com/puppetlabs/r10k) which helps you to provision a server running dcm4chee and OpenMRS.

The goal is to ease development and help get people started with the OpenMRS module [openmrs-module-radiology] (https://github.com/openmrs/openmrs-module-radiology) a module adding RIS capabilities to OpenMRS.

The provisioning of openmrs and dcm4chee is done by the following custom puppet modules:
* [teleivo/dcm4chee] (https://github.com/teleivo/puppet-dcm4chee)
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

This will download a virtualbox VM with Ubuntu 14.04 64bit, install all necessary puppet modules via [r10k] (https://github.com/puppetlabs/r10k) and run the manifest/site.pp which
* installs mysql server
* installs [dcm4chee] (http://www.dcm4che.org/) and deploys DICOM viewer [weasis] (https://github.com/nroduit/Weasis)
* installs tomcat 7 and deploys [OpenMRS] (http://openmrs.org/) version 1.11.4

*Note: vagrant up will deploy the puppet code that is on a remote branch named like
the branch you are currently on. (By default: master)*

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
A few things are still needed to finish the installation and integrate OpenMRS with dcm4chee:
#####OpenMRS
Run through the [OpenMRS](http://localhost:8080/openmrs/) wizard to finish
the OpenMRS installation. **Note that the OpenMRS database has not yet been created but
will be created by the wizard. The database user openmrs (password=openmrs) with "CREATE
DATABASE" privileges does already exist.**

In the wizard select/enter the following:
* Which type of installation do you want? => Advanced
* Step 1 of 5, Do you currently have an OpenMRS database installed that you
would like to connect to? => No
  - If no, what would you like to name this database? Database name => openmrs
  - A user that has "CREATE DATABASE" privileges must be specified here...
    * Username => openmrs
    * Password => openmrs
* Step 2 of 5, Do you currently have a database user other than root that has
read/write access to the openmrs database? => Yes
  - If yes, specify the login user name and password for that database user
    * Username => openmrs
    * Password => openmrs
* Complete the remaining steps of the wizard

Refer to [openmrs-module-radiology] (https://github.com/openmrs/openmrs-module-radiology) on how to build and deploy the radiology module in OpenMRS.

#####dcm4chee
* configure weasis as the web viewer at [localhost:8081/jmx-console/](http://localhost:8081/jmx-console/) section **dcm4chee.web, service=WebConfig** set
  - WebviewerNames= *weasis*
  - WebviewerBaseUrls= *weasis:/weasis-pacs-connector/viewer-applet*
* add the radiology module as DICOM Application Entity at [localhost:8081/dcm4chee-web3/](http://localhost:8081/dcm4chee-web3/)
* configure DICOM MPPS message forwarding to the OpenMRS radiology module at [localhost:8081/jmx-console/](http://localhost:8081/jmx-console/) section **dcm4chee.archive, service=MPPSScu**

###How to speed up recreating a fresh VM
Once you have completed all steps in [How to get started](#how-to-get-started) its a good idea to create your own custom vagrant box.
This will allow you to quickly recreate a fresh VM without having to go through all the installation and configuration again :)

So make sure you have fully completed the setup as described above and issue the following commands
```
vagrant package --output openmrs-radiologydcm4chee.box
vagrant box add openmrs-radiologydcm4chee.box --name openmrs-radiologydcm4chee
```

To setup a new VM using your custom box, create a new directory and in it execute
```
vagrant init openmrs-radiologydcm4chee
```

##Limitations

Currently you will only be able to run this on a machine providing support for 64bit virtualization which is due to the puppet module [teleivo/dcm4chee] (https://github.com/teleivo/puppet-dcm4chee).

##Development

###Running tests
This project contains a rake task to verify linitan errors and syntax.

To install all dependencies for the testing environment:
```bash
sudo gem install bundler
bundle install
```

To run the checks execute:
```bash
bundle exec rake test
```

##Further reading
For infos about puppet control repositories and roles/profiles please read
* https://docs.puppetlabs.com/pe/latest/quick_start_r10k.html
* http://garylarizza.com/blog/2014/02/17/puppet-workflow-part-2/

