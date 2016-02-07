# Role for installing/configuring RIS/PACS applications
class role::rispacs {

  include 'profile::packages'
  include 'mysql::server'

  class { 'profile::java_oracle':
    require => Class['profile::packages'],
  }

  class { 'profile::tomcat':
    require => Class['profile::packages'],
  }

  class { 'profile::openmrs':
    require => [ Class['profile::packages'],
                Class['profile::tomcat'],
    ]
  }

  class { 'profile::dcm4chee':
    require => [ Class['profile::packages'],
                Class['profile::java_oracle'],
    ]
  }
}
