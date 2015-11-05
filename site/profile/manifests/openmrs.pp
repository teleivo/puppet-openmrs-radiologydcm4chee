# Profile for installing/configuring openmrs
class profile::openmrs {
  $tomcat_user = hiera('tomcat_user')
  $tomcat_catalina_base = hiera('tomcat_catalina_base')
  $openmrs_application_data_directory = hiera('openmrs_application_data_directory')
  $database_host = hiera('database_host')
  $openmrs_database_name = hiera('openmrs_database_name')
  $openmrs_database_owner = hiera('openmrs_database_owner')
  $openmrs_database_owner_password = hiera('openmrs_database_owner_password')

  class { '::openmrs':
    tomcat_catalina_base               => $tomcat_catalina_base,
    tomcat_user                        => $tomcat_user,
    openmrs_application_data_directory => $openmrs_application_data_directory,
    db_host                            => $database_host,
    db_name                            => $openmrs_database_name,
    db_owner                           => $openmrs_database_owner,
    db_owner_password                  => $openmrs_database_owner_password,
  }

  file { [ "${tomcat_catalina_base}/mwl",
        "${tomcat_catalina_base}/mpps" ]:
    ensure  => 'directory',
    owner   => $tomcat_user,
    group   => $tomcat_user,
    mode    => '0755',
    require => Class['::openmrs'],
  }

  # did not specify fully qualified class name because
  # its only supported from puppet >= 3.7 on
  # and current puppet version is 3.4.3 on Ubuntu
  contain 'openmrs'
}
