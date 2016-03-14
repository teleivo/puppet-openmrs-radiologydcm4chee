# Role for installing/configuring RIS/PACS applications
class role::rispacs {

  include 'profile::packages'
  include 'mysql::server'

  $openmrs_db_owner = hiera('openmrs::db_owner', 'openmrs')
  $openmrs_db_owner_password = hiera('openmrs::db_owner_password', 'openmrs')
  $openmrs_db_name = hiera('openmrs::db_name', 'openmrs')
  $mysql_user_name_local = "${openmrs_db_owner}@localhost"
  $mysql_user_name_all = "${openmrs_db_owner}@%"
  mysql_user { $mysql_user_name_all:
    ensure        => 'present',
    password_hash => mysql_password($openmrs_db_owner_password),
  }
  mysql_grant { "${mysql_user_name_local}/*.*":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => "*.*",
    user       => $mysql_user_name_local,
    require    => Mysql_user[$mysql_user_name_local]
  }
  mysql_grant { "${mysql_user_name_all}/*.*":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => "*.*",
    user       => $mysql_user_name_all,
    require    => Mysql_user[$mysql_user_name_all]
  }
  mysql_grant { "${mysql_user_name_all}/${openmrs_db_name}.*":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => "${openmrs_db_name}.*",
    user       => $mysql_user_name_all,
    require    => Mysql_user[$mysql_user_name_all]
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
