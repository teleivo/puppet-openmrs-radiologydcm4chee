#!/bin/bash
# Upgrade puppet, install git and r10k

apt-get -q -y update
apt-get -q -y install git

# upgrade puppet to 3.8
apt-get -q -y purge puppet puppet-common hiera
apt-get -q -y autoremove
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb -O /tmp/puppetlabs-release-trusty.deb
dpkg -i /tmp/puppetlabs-release-trusty.deb
cat > /etc/apt/preferences.d/00puppet.pref <<EOF
Package: puppet puppet-common
Pin: version 3.8*
Pin-Priority: 550
EOF
apt-get update
apt-get -q -y install puppet

cp /vagrant/global-hiera.yaml /etc/hiera.yaml
ln -s /etc/hiera.yaml /etc/puppet/hiera.yaml

apt-get -q -y install build-essential \
    ruby1.9.1-dev
gem install r10k
