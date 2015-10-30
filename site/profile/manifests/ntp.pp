# Profile for installing/configuring ntp
class profile::ntp {

  class { '::ntp':
    servers => [ '0.at.pool.ntp.org',
              '1.at.pool.ntp.org',
              '2.at.pool.ntp.org',
              '3.at.pool.ntp.org'
    ],
  }
  # did not specify fully qualified class name because
  # its only supported from puppet >= 3.7 on
  # and current puppet version is 3.4.3 on Ubuntu
  contain 'ntp'
}

