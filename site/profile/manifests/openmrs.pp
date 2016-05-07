# Profile for installing/configuring openmrs
class profile::openmrs {

  $tomcat_user = hiera('openmrs::tomcat_user')
  $tomcat_catalina_base = hiera('openmrs::tomcat_catalina_base')

  ::postgresql::server::db { 'openmrs':
    owner     => 'openmrs',
    user      => 'openmrs',
    password  => postgresql_password('openmrs', 'openmrs'),
    grant     => 'ALL',
  }

  #contain '::openmrs'

  #file { [ "${tomcat_catalina_base}/mwl",
        #"${tomcat_catalina_base}/mpps" ]:
    #ensure  => 'directory',
    #owner   => $tomcat_user,
    #group   => $tomcat_user,
    #mode    => '0755',
    #require => Class['::openmrs'],
  #}
}
