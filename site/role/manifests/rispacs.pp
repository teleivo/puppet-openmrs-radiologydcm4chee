# Role for installing/configuring RIS/PACS applications
class role::rispacs {

  include 'profile::packages'
  include 'mysql::server'

  $openmrs_db_owner = hiera('openmrs::db_owner')
  $openmrs_db_name = hiera('openmrs::db_name')
  mysql_grant { "${openmrs_db_owner}@'%'/${openmrs_db_name}.*":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => '*.*',
    user       => "${openmrs_db_name}@'%'",
  }

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
