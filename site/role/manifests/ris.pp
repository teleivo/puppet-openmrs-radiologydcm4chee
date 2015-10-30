# Role for installing/configuring RIS application
class role::ris {

  contain 'profile::ntp'
  contain 'profile::packages'
  contain 'profile::mysql'
  contain 'profile::java_oracle'
  contain 'profile::tomcat'
  contain 'profile::openmrs'

  Class['profile::ntp']->
  Class['profile::packages']->
  Class['profile::mysql']->
  Class['profile::java_oracle']->
  Class['profile::tomcat']->
  Class['profile::openmrs']
}

