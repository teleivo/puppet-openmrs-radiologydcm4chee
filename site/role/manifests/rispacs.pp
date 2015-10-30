# Role for installing/configuring RIS/PACS applications
class role::rispacs {

  contain 'profile::ntp'
  contain 'profile::packages'
  contain 'profile::mysql'

  class { 'profile::java_oracle':
    require => Class['profile::packages'],
  }
  contain 'profile::java_oracle'

  class { 'profile::tomcat':
    require => [ Class['profile::packages'],
                Class['profile::java_oracle'],
                Class['profile::ntp'],
    ]
  }
  contain 'profile::tomcat'

  class { 'profile::openmrs':
    require => [ Class['profile::packages'],
                Class['profile::mysql'],
                Class['profile::java_oracle'],
                Class['profile::tomcat'],
                Class['profile::ntp'],
    ]
  }
  contain 'profile::openmrs'

  class { 'profile::dcm4chee':
    require => [ Class['profile::packages'],
                Class['profile::mysql'],
                Class['profile::java_oracle'],
                Class['profile::ntp'],
    ]
  }
  contain 'profile::dcm4chee'
}
