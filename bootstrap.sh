#!/bin/bash
# Install git and r10k

apt-get -q -y update
apt-get -q -y install git

apt-get -q -y install build-essential \
    ruby1.9.1-dev
gem install r10k
