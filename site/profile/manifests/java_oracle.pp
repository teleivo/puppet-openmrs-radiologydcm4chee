# Profile for installing/configuring oracle java
class profile::java_oracle {
  $java_version_major = hiera('java_version_major')
  $java_version_update = hiera('java_version_update')
  $java_install_dir = hiera('java_install_dir')

  class { 'jdk_oracle':
    version        => $java_version_major,
    version_update => $java_version_update,
    install_dir    => $java_install_dir,
  }
  # did not specify fully qualified class name because
  # its only supported from puppet >= 3.7 on
  # and current puppet version is 3.4.3 on Ubuntu
  contain 'jdk_oracle'
}
