# Profile for installing necessary packages
class profile::packages {

  package { [ 'unzip',
              'curl',
              'python-software-properties',
              'software-properties-common' ]:
    ensure => present
  }
}
