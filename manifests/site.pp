Exec {
    path => [ '/usr/bin', '/bin', '/usr/sbin', '/sbin' ]
}

package { [ 'unzip', 'curl', 'python-software-properties', 'software-properties-common' ]: }

include 'mysql::server'

class { 'java7':
  require => [ Package['python-software-properties'],
  Package['software-properties-common'] ]
}

class { 'openmrs':
    require   => [ Package['unzip'], Package['curl'], Class['java7'] ]
}

class { 'dcm4chee':
    java_path => '/usr/lib/jvm/java-7-oracle/jre/bin/java',
    require   => [ Package['unzip'], Package['curl'], Class['java7'] ]
}

