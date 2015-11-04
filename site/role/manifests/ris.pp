# Role for installing/configuring RIS application
class role::ris {

  contain 'profile::packages'
  contain 'profile::mysql'
  contain 'profile::tomcat'
  contain 'profile::openmrs'

  Class['profile::packages']->
  Class['profile::mysql']->
  Class['profile::tomcat']->
  Class['profile::openmrs']
}

