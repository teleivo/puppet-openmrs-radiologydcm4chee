# Profile for installing/configuring mysql server
class profile::mysql {

  # did not specify fully qualified class name because
  # its only supported from puppet >= 3.7 on
  # and current puppet version is 3.4.3 on Ubuntu
  contain 'mysql::server'
}
