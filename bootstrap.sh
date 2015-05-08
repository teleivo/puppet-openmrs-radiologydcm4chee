#!/bin/bash

# Directory in which librarian-puppet should manage its modules directory
PUPPET_DIR=/vagrant

apt-get -q -y update
apt-get -q -y install git

apt-get -q -y install build-essential \
    ruby1.9.1-dev
gem install librarian-puppet
cd $PUPPET_DIR && librarian-puppet install
