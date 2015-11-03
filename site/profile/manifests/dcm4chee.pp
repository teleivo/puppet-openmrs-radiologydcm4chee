# Profile for installing/configuring PACS dcm4chee
class profile::dcm4chee {
  $java_path = hiera('java_path')
  $jboss_http_port = hiera('dcm4chee_jboss_http_port')
  $jboss_ajp_connector_port = hiera('dcm4chee_jboss_ajp_connector_port')
  $jboss_java_opts = hiera('dcm4chee_jboss_java_opts')

  class { '::dcm4chee':
    java_path                => $java_path,
    jboss_http_port          => $jboss_http_port,
    jboss_ajp_connector_port => $jboss_ajp_connector_port,
    jboss_java_opts          => $jboss_java_opts,
  }
  # did not specify fully qualified class name because
  # its only supported from puppet >= 3.7 on
  # and current puppet version is 3.4.3 on Ubuntu
  contain 'dcm4chee'
}
