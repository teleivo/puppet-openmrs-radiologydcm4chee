# Profile for installing/configuring openmrs
class profile::openmrs {
  $tomcat_user = hiera('tomcat_user')
  $tomcat_catalina_base = hiera('tomcat_catalina_base')
  $openmrs_application_data_directory = hiera('openmrs_application_data_directory')

  class { '::openmrs':
    tomcat_catalina_base               => $tomcat_catalina_base,
    tomcat_user                        => $tomcat_user,
    openmrs_application_data_directory => $openmrs_application_data_directory,
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
