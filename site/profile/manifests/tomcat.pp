# Profile for installing/configuring tomcat7
class profile::tomcat {

  $tomcat_catalina_base = hiera('tomcat_catalina_base')
  $tomcat_java_opts = hiera('tomcat_java_opts', [
                                                '-Djava.awt.headless=true',
                                                '-Xmx128m',
                                                '-XX:+UseConcMarkSweepGC',
  ])
  $tomcat_instance_name = 'tomcat7'
  $tomcat_package_name = 'tomcat7'
  $tomcat_admin_package_name = 'tomcat7-admin'
  $tomcat_service_name = 'tomcat7'

  contain '::tomcat'

  ::tomcat::instance { $tomcat_instance_name:
    package_name => $tomcat_package_name,
    require      => Class['::tomcat'],
  }

  $tomcat_java_opts_string = join($tomcat_java_opts, ' ')
  augeas { 'JAVA_OPTS':
    context => "/files/etc/default/${tomcat_instance_name}/",
    changes => "set JAVA_OPTS \"'${tomcat_java_opts_string}'\"",
    require => Tomcat::Instance[$tomcat_instance_name],
    notify  => Tomcat::Service[$tomcat_service_name],
  }

  package { $tomcat_admin_package_name:
    ensure  => present,
    require => Tomcat::Instance[$tomcat_instance_name],
  }

  ::tomcat::config::server::tomcat_users { 'admin':
    ensure        => present,
    catalina_base => $tomcat_catalina_base,
    password      => 'admin',
    roles         => [ 'manager-gui',
                      'admin-gui'
    ],
    require       => Tomcat::Instance[$tomcat_instance_name],
    notify        => Tomcat::Service[$tomcat_service_name],
  }

  ::tomcat::service { $tomcat_service_name:
    use_init       => true,
    service_name   => $tomcat_service_name,
    service_ensure => running,
    require        => Tomcat::Instance[$tomcat_instance_name],
  }
}
