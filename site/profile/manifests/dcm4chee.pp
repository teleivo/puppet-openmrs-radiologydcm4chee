# Profile for installing/configuring PACS dcm4chee
class profile::dcm4chee {
  $java_oracle_path = hiera('java_oracle_path')
  $database_host = hiera('database_host')
  $dcm4chee_database_name = hiera('dcm4chee_database_name')
  $dcm4chee_database_owner = hiera('dcm4chee_database_owner')
  $dcm4chee_database_owner_password = hiera('dcm4chee_database_owner_password')
  $jboss_http_port = hiera('dcm4chee_jboss_http_port')
  $jboss_ajp_connector_port = hiera('dcm4chee_jboss_ajp_connector_port')
  $jboss_java_opts = hiera('dcm4chee_jboss_java_opts')

  class { '::dcm4chee':
    java_path                => $java_oracle_path,
    db_host                  => $database_host,
    db_name                  => $dcm4chee_database_name,
    db_owner                 => $dcm4chee_database_owner,
    db_owner_password        => $dcm4chee_database_owner_password,
    jboss_http_port          => $jboss_http_port,
    jboss_ajp_connector_port => $jboss_ajp_connector_port,
    jboss_java_opts          => $jboss_java_opts,
  }
  # did not specify fully qualified class name because
  # its only supported from puppet >= 3.7 on
  # and current puppet version is 3.4.3 on Ubuntu
  contain 'dcm4chee'
}
