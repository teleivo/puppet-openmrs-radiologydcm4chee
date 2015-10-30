Exec {
    path => [ '/usr/bin', '/bin', '/usr/sbin', '/sbin' ]
}

node default {
    include role::javatest
}
